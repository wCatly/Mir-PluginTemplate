local ffi = require "ffi"

local ffi_cdef = function(code)
    local ret,err = pcall(ffi.cdef,code)
    if not ret then
        local lineN = 1
        for line in code:gmatch("([^\n\r]*)\r?\n") do
            print(lineN, line)
            lineN = lineN + 1
        end
        print(err)
        error"bad cdef"
    end
end

--load dll
local lib = ffi.C

-----------ImStr definition
local ImStrv
if pcall(function() local a = ffi.new("ImStrv")end) then

ImStrv= {}
function ImStrv.__new(ctype,a,b)
	b = b or ffi.new("const char*",a) + (a and #a or 0)
	return ffi.new(ctype,a,b)
end
function ImStrv.__tostring(is)
	return is.Begin~=nil and ffi.string(is.Begin,is.End~=nil and is.End-is.Begin or nil) or nil
end
ImStrv.__index = ImStrv
ImStrv = ffi.metatype("ImStrv",ImStrv)

end

local M = {ImVec2 = ImVec2, ImVec4 = ImVec4 , ImStrv = ImStrv, lib = lib}

if jit.os == "Windows" then
    function M.ToUTF(unc_str)
        local buf_len = lib.igImTextCountUtf8BytesFromStr(unc_str, nil) + 1;
        local buf_local = ffi.new("char[?]",buf_len)
        lib.igImTextStrToUtf8(buf_local, buf_len, unc_str, nil);
        return buf_local
    end
    
    function M.FromUTF(utf_str)
        local wbuf_length = lib.igImTextCountCharsFromUtf8(utf_str, nil) + 1;
        local buf_local = ffi.new("ImWchar[?]",wbuf_length)
        lib.igImTextStrFromUtf8(buf_local, wbuf_length, utf_str, nil,nil);
        return buf_local
    end
end

M.FLT_MAX = lib.igGET_FLT_MAX()
M.FLT_MIN = lib.igGET_FLT_MIN()

------------convenience function
function M.U32(a,b,c,d) return lib.igGetColorU32_Vec4(ImVec4(a,b,c,d or 1)) end

-------------ImGuiZMO.quat

function M.mat4_cast(q)
	local nonUDT_out = ffi.new("Mat4")
	lib.mat4_cast(q,nonUDT_out)
	return nonUDT_out
end
function M.mat4_pos_cast(q,pos)
	local nonUDT_out = ffi.new("Mat4")
	lib.mat4_pos_cast(q,pos,nonUDT_out)
	return nonUDT_out
end
function M.quat_cast(f)
	local nonUDT_out = ffi.new("quat")
	lib.quat_cast(f,nonUDT_out)
	return nonUDT_out
end
function M.quat_pos_cast(f)
	local nonUDT_out = ffi.new("quat")
	local nonUDT_pos = ffi.new("G3Dvec3")
	lib.quat_pos_cast(f,nonUDT_out,nonUDT_pos)
	return nonUDT_out,nonUDT_pos
end

--------------- several widgets------------
local sin, cos, atan2, pi, max, min,acos,sqrt = math.sin, math.cos, math.atan2, math.pi, math.max, math.min,math.acos,math.sqrt
function M.dial(label,value_p,sz, fac)

	fac = fac or 1
	sz = sz or 20
	local style = M.GetStyle()
	
	local p = M.GetCursorScreenPos();

	local radio =  sz*0.5
	local center = M.ImVec2(p.x + radio, p.y + radio)
	
	local x2 = cos(value_p[0]/fac)*radio + center.x
	local y2 = sin(value_p[0]/fac)*radio + center.y
	
	M.InvisibleButton(label.."t",M.ImVec2(sz, sz)) 
	local is_active = M.IsItemActive()
	local is_hovered = M.IsItemHovered()
	
	local touched = false
	if is_active then 
		touched = true
		local m = M.GetIO().MousePos
		local md = M.GetIO().MouseDelta
		if md.x == 0 and md.y == 0 then touched=false end
		local mp = M.ImVec2(m.x - md.x, m.y - md.y)
		local ax = mp.x - center.x
		local ay = mp.y - center.y
		local bx = m.x - center.x
		local by = m.y - center.y
		local ma = sqrt(ax*ax + ay*ay)
		local mb = sqrt(bx*bx + by*by)
		local ab  = ax * bx + ay * by;
		local vet = ax * by - bx * ay;
		ab = ab / (ma * mb);
		if not (ma == 0 or mb == 0 or ab < -1 or ab > 1) then

			if (vet>0) then
				value_p[0] = value_p[0] + acos(ab)*fac;
			else 
				value_p[0] = value_p[0] - acos(ab)*fac;
			end
		end
	end
	
	local col32idx = is_active and lib.ImGuiCol_FrameBgActive or (is_hovered and lib.ImGuiCol_FrameBgHovered or lib.ImGuiCol_FrameBg)
	local col32 = M.GetColorU32(col32idx, 1) 
	local col32line = M.GetColorU32(lib.ImGuiCol_SliderGrabActive, 1) 
	local draw_list = M.GetWindowDrawList();
	draw_list:AddCircleFilled( center, radio, col32, 16);
	draw_list:AddLine( center, M.ImVec2(x2, y2), col32line, 1);
	M.SameLine()
	M.PushItemWidth(50)
	if M.InputFloat(label, value_p, 0.0, 0.1) then
		touched = true
	end
	M.PopItemWidth()
	return touched
end

function M.Curve(name,numpoints,LUTsize,pressed_on_modified)
	if pressed_on_modified == nil then pressed_on_modified=true end
	numpoints = numpoints or 10
	LUTsize = LUTsize or 720
	local CU = {name = name,numpoints=numpoints,LUTsize=LUTsize}
	CU.LUT = ffi.new("float[?]",LUTsize)
	CU.LUT[0] = -1
	CU.points = ffi.new("ImVec2[?]",numpoints)
	CU.points[0].x = -1
	function CU:getpoints()
		local pts = {}
		for i=0,numpoints-1 do
			pts[i+1] = {x=CU.points[i].x,y=CU.points[i].y}
		end
		return pts
	end
	function CU:setpoints(pts)
		assert(#pts<=numpoints)
		for i=1,#pts do
			CU.points[i-1].x = pts[i].x
			CU.points[i-1].y = pts[i].y
		end
		CU.LUT[0] = -1
		lib.CurveGetData(CU.points, numpoints,CU.LUT, LUTsize )
	end
	function CU:get_data()
		CU.LUT[0] = -1
		lib.CurveGetData(CU.points, numpoints,CU.LUT, LUTsize )
	end
	function CU:draw(sz)
		sz = sz or M.ImVec2(200,200)
		return lib.Curve(name, sz,CU.points, CU.numpoints,CU.LUT, CU.LUTsize,pressed_on_modified) 
	end
	return CU
end


function M.pad(label,value,sz)
	local function clip(val,mini,maxi) return math.min(maxi,math.max(mini,val)) end
	sz = sz or 200
	local canvas_pos = M.GetCursorScreenPos();
	M.InvisibleButton(label.."t",M.ImVec2(sz, sz)) -- + style.ItemInnerSpacing.y))
	local is_active = M.IsItemActive()
	local is_hovered = M.IsItemHovered()
	local touched = false
	if is_active then
		touched = true
		local m = M.GetIO().MousePos
		local md = M.GetIO().MouseDelta
		if md.x == 0 and md.y == 0 and not M.IsMouseClicked(0,false) then touched=false end
		value[0] = ((m.x - canvas_pos.x)/sz)*2 - 1
		value[1] = (1.0 - (m.y - canvas_pos.y)/sz)*2 - 1
		value[0] = clip(value[0], -1,1)
		value[1] = clip(value[1], -1,1)
	end
	local draw_list = M.GetWindowDrawList();
	draw_list:AddRect(canvas_pos,canvas_pos+M.ImVec2(sz,sz),M.U32(1,0,0,1))
	draw_list:AddLine(canvas_pos + M.ImVec2(0,sz/2),canvas_pos + M.ImVec2(sz,sz/2) ,M.U32(1,0,0,1))
	draw_list:AddLine(canvas_pos + M.ImVec2(sz/2,0),canvas_pos + M.ImVec2(sz/2,sz) ,M.U32(1,0,0,1))
	draw_list:AddCircleFilled(canvas_pos + M.ImVec2((1+value[0])*sz,((1-value[1])*sz)+1)*0.5,5,M.U32(1,0,0,1))
	return touched
end

function M.Plotter(xmin,xmax,nvals)
	local Graph = {xmin=xmin or 0,xmax=xmax or 1,nvals=nvals or 400}
	function Graph:init()
		self.values = ffi.new("float[?]",self.nvals)
	end
	function Graph:itox(i)
		return self.xmin + i/(self.nvals-1)*(self.xmax-self.xmin)
	end
	function Graph:calc(func,ymin1,ymax1)
		local vmin = math.huge
		local vmax = -math.huge
		for i=0,self.nvals-1 do
			self.values[i] = func(self:itox(i))
			vmin = (vmin < self.values[i]) and vmin or self.values[i]
			vmax = (vmax > self.values[i]) and vmax or self.values[i]
		end
		self.ymin = ymin1 or vmin
		self.ymax = ymax1 or vmax
	end
	function Graph:draw()
	
		local regionsize = M.GetContentRegionAvail()
		local desiredY = regionsize.y - M.GetFrameHeightWithSpacing()
		M.PushItemWidth(-1)
		M.PlotLines("##grafica",self.values,self.nvals,nil,nil,self.ymin,self.ymax,M.ImVec2(0,desiredY))
		local p = M.GetCursorScreenPos() 
		p.y = p.y - M.GetStyle().FramePadding.y
		local w = M.CalcItemWidth()
		self.origin = p
		self.size = M.ImVec2(w,desiredY)
		
		local draw_list = M.GetWindowDrawList()
		for i=0,4 do
			local ylab = i*desiredY/4 --+ M.GetStyle().FramePadding.y
			draw_list:AddLine(M.ImVec2(p.x, p.y - ylab), M.ImVec2(p.x + w,p.y - ylab), M.U32(1,0,0,1))
			local valy = self.ymin + (self.ymax - self.ymin)*i/4
			local labelY = string.format("%0.3f",valy)
			-- - M.CalcTextSize(labelY).x
			draw_list:AddText(M.ImVec2(p.x , p.y -ylab), M.U32(0,1,0,1),labelY)
		end
	
		for i=0,10 do
			local xlab = i*w/10
			draw_list:AddLine(M.ImVec2(p.x + xlab,p.y), M.ImVec2(p.x + xlab,p.y - desiredY), M.U32(1,0,0,1))
			local valx = self:itox(i/10*(self.nvals -1))
			draw_list:AddText(M.ImVec2(p.x + xlab,p.y + 2), M.U32(0,1,0,1),string.format("%0.3f",valx))
		end
		
		M.PopItemWidth()
		
		return w,desiredY
	end
	Graph:init()
	return Graph
end


----------BEGIN_AUTOGENERATED_LUA---------------------------
--------------------------ImBitVector----------------------------
local ImBitVector= {}
ImBitVector.__index = ImBitVector
ImBitVector.Clear = lib.ImBitVector_Clear
ImBitVector.ClearBit = lib.ImBitVector_ClearBit
ImBitVector.Create = lib.ImBitVector_Create
ImBitVector.SetBit = lib.ImBitVector_SetBit
ImBitVector.TestBit = lib.ImBitVector_TestBit
M.ImBitVector = ffi.metatype("ImBitVector",ImBitVector)
--------------------------ImColor----------------------------
local ImColor= {}
ImColor.__index = ImColor
function M.ImColor_HSV(h,s,v,a)
    a = a or 1.0
    local nonUDT_out = ffi.new("ImColor")
    lib.ImColor_HSV(nonUDT_out,h,s,v,a)
    return nonUDT_out
end
function ImColor.ImColor_Nil()
    local ptr = lib.ImColor_ImColor_Nil()
    return ffi.gc(ptr,lib.ImColor_destroy)
end
function ImColor.ImColor_Float(r,g,b,a)
    if a == nil then a = 1.0 end
    local ptr = lib.ImColor_ImColor_Float(r,g,b,a)
    return ffi.gc(ptr,lib.ImColor_destroy)
end
function ImColor.ImColor_Vec4(col)
    local ptr = lib.ImColor_ImColor_Vec4(col)
    return ffi.gc(ptr,lib.ImColor_destroy)
end
function ImColor.ImColor_Int(r,g,b,a)
    if a == nil then a = 255 end
    local ptr = lib.ImColor_ImColor_Int(r,g,b,a)
    return ffi.gc(ptr,lib.ImColor_destroy)
end
function ImColor.ImColor_U32(rgba)
    local ptr = lib.ImColor_ImColor_U32(rgba)
    return ffi.gc(ptr,lib.ImColor_destroy)
end
function ImColor.__new(ctype,a1,a2,a3,a4) -- generic version
    if a1==nil then return ImColor.ImColor_Nil() end
    if (ffi.istype('float',a1) or type(a1)=='number') then return ImColor.ImColor_Float(a1,a2,a3,a4) end
    if ffi.istype('const ImVec4',a1) then return ImColor.ImColor_Vec4(a1) end
    if (ffi.istype('int',a1) or type(a1)=='number') then return ImColor.ImColor_Int(a1,a2,a3,a4) end
    if (ffi.istype('ImU32',a1) or type(a1)=='number') then return ImColor.ImColor_U32(a1) end
    print(ctype,a1,a2,a3,a4)
    error'ImColor.__new could not find overloaded'
end
function ImColor:SetHSV(h,s,v,a)
    a = a or 1.0
    return lib.ImColor_SetHSV(self,h,s,v,a)
end
M.ImColor = ffi.metatype("ImColor",ImColor)
--------------------------ImDrawCmd----------------------------
local ImDrawCmd= {}
ImDrawCmd.__index = ImDrawCmd
ImDrawCmd.GetTexID = lib.ImDrawCmd_GetTexID
function ImDrawCmd.__new(ctype)
    local ptr = lib.ImDrawCmd_ImDrawCmd()
    return ffi.gc(ptr,lib.ImDrawCmd_destroy)
end
M.ImDrawCmd = ffi.metatype("ImDrawCmd",ImDrawCmd)
--------------------------ImDrawData----------------------------
local ImDrawData= {}
ImDrawData.__index = ImDrawData
ImDrawData.Clear = lib.ImDrawData_Clear
ImDrawData.DeIndexAllBuffers = lib.ImDrawData_DeIndexAllBuffers
function ImDrawData.__new(ctype)
    local ptr = lib.ImDrawData_ImDrawData()
    return ffi.gc(ptr,lib.ImDrawData_destroy)
end
ImDrawData.ScaleClipRects = lib.ImDrawData_ScaleClipRects
M.ImDrawData = ffi.metatype("ImDrawData",ImDrawData)
--------------------------ImDrawDataBuilder----------------------------
local ImDrawDataBuilder= {}
ImDrawDataBuilder.__index = ImDrawDataBuilder
ImDrawDataBuilder.Clear = lib.ImDrawDataBuilder_Clear
ImDrawDataBuilder.ClearFreeMemory = lib.ImDrawDataBuilder_ClearFreeMemory
ImDrawDataBuilder.FlattenIntoSingleLayer = lib.ImDrawDataBuilder_FlattenIntoSingleLayer
ImDrawDataBuilder.GetDrawListCount = lib.ImDrawDataBuilder_GetDrawListCount
M.ImDrawDataBuilder = ffi.metatype("ImDrawDataBuilder",ImDrawDataBuilder)
--------------------------ImDrawList----------------------------
local ImDrawList= {}
ImDrawList.__index = ImDrawList
function ImDrawList:AddBezierCubic(p1,p2,p3,p4,col,thickness,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_AddBezierCubic(self,p1,p2,p3,p4,col,thickness,num_segments)
end
function ImDrawList:AddBezierQuadratic(p1,p2,p3,col,thickness,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_AddBezierQuadratic(self,p1,p2,p3,col,thickness,num_segments)
end
ImDrawList.AddCallback = lib.ImDrawList_AddCallback
function ImDrawList:AddCircle(center,radius,col,num_segments,thickness)
    num_segments = num_segments or 0
    thickness = thickness or 1.0
    return lib.ImDrawList_AddCircle(self,center,radius,col,num_segments,thickness)
end
function ImDrawList:AddCircleFilled(center,radius,col,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_AddCircleFilled(self,center,radius,col,num_segments)
end
ImDrawList.AddConvexPolyFilled = lib.ImDrawList_AddConvexPolyFilled
ImDrawList.AddDrawCmd = lib.ImDrawList_AddDrawCmd
function ImDrawList:AddImage(user_texture_id,p_min,p_max,uv_min,uv_max,col)
    col = col or 4294967295
    uv_max = uv_max or ImVec2(1,1)
    uv_min = uv_min or ImVec2(0,0)
    return lib.ImDrawList_AddImage(self,user_texture_id,p_min,p_max,uv_min,uv_max,col)
end
function ImDrawList:AddImageQuad(user_texture_id,p1,p2,p3,p4,uv1,uv2,uv3,uv4,col)
    col = col or 4294967295
    uv1 = uv1 or ImVec2(0,0)
    uv2 = uv2 or ImVec2(1,0)
    uv3 = uv3 or ImVec2(1,1)
    uv4 = uv4 or ImVec2(0,1)
    return lib.ImDrawList_AddImageQuad(self,user_texture_id,p1,p2,p3,p4,uv1,uv2,uv3,uv4,col)
end
function ImDrawList:AddImageRounded(user_texture_id,p_min,p_max,uv_min,uv_max,col,rounding,flags)
    flags = flags or 0
    return lib.ImDrawList_AddImageRounded(self,user_texture_id,p_min,p_max,uv_min,uv_max,col,rounding,flags)
end
function ImDrawList:AddLine(p1,p2,col,thickness)
    thickness = thickness or 1.0
    return lib.ImDrawList_AddLine(self,p1,p2,col,thickness)
end
function ImDrawList:AddNgon(center,radius,col,num_segments,thickness)
    thickness = thickness or 1.0
    return lib.ImDrawList_AddNgon(self,center,radius,col,num_segments,thickness)
end
ImDrawList.AddNgonFilled = lib.ImDrawList_AddNgonFilled
ImDrawList.AddPolyline = lib.ImDrawList_AddPolyline
function ImDrawList:AddQuad(p1,p2,p3,p4,col,thickness)
    thickness = thickness or 1.0
    return lib.ImDrawList_AddQuad(self,p1,p2,p3,p4,col,thickness)
end
ImDrawList.AddQuadFilled = lib.ImDrawList_AddQuadFilled
function ImDrawList:AddRect(p_min,p_max,col,rounding,flags,thickness)
    flags = flags or 0
    rounding = rounding or 0.0
    thickness = thickness or 1.0
    return lib.ImDrawList_AddRect(self,p_min,p_max,col,rounding,flags,thickness)
end
function ImDrawList:AddRectFilled(p_min,p_max,col,rounding,flags)
    flags = flags or 0
    rounding = rounding or 0.0
    return lib.ImDrawList_AddRectFilled(self,p_min,p_max,col,rounding,flags)
end
ImDrawList.AddRectFilledMultiColor = lib.ImDrawList_AddRectFilledMultiColor
function ImDrawList:AddText_Vec2(pos,col,text_begin,text_end)
    text_end = text_end or nil
    return lib.ImDrawList_AddText_Vec2(self,pos,col,text_begin,text_end)
end
function ImDrawList:AddText_FontPtr(font,font_size,pos,col,text_begin,text_end,wrap_width,cpu_fine_clip_rect)
    cpu_fine_clip_rect = cpu_fine_clip_rect or nil
    text_end = text_end or nil
    wrap_width = wrap_width or 0.0
    return lib.ImDrawList_AddText_FontPtr(self,font,font_size,pos,col,text_begin,text_end,wrap_width,cpu_fine_clip_rect)
end
function ImDrawList:AddText(a2,a3,a4,a5,a6,a7,a8,a9) -- generic version
    if ffi.istype('const ImVec2',a2) then return self:AddText_Vec2(a2,a3,a4,a5) end
    if (ffi.istype('const ImFont*',a2) or ffi.istype('const ImFont',a2) or ffi.istype('const ImFont[]',a2)) then return self:AddText_FontPtr(a2,a3,a4,a5,a6,a7,a8,a9) end
    print(a2,a3,a4,a5,a6,a7,a8,a9)
    error'ImDrawList:AddText could not find overloaded'
end
function ImDrawList:AddTriangle(p1,p2,p3,col,thickness)
    thickness = thickness or 1.0
    return lib.ImDrawList_AddTriangle(self,p1,p2,p3,col,thickness)
end
ImDrawList.AddTriangleFilled = lib.ImDrawList_AddTriangleFilled
ImDrawList.ChannelsMerge = lib.ImDrawList_ChannelsMerge
ImDrawList.ChannelsSetCurrent = lib.ImDrawList_ChannelsSetCurrent
ImDrawList.ChannelsSplit = lib.ImDrawList_ChannelsSplit
ImDrawList.CloneOutput = lib.ImDrawList_CloneOutput
function ImDrawList:GetClipRectMax()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImDrawList_GetClipRectMax(nonUDT_out,self)
    return nonUDT_out
end
function ImDrawList:GetClipRectMin()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImDrawList_GetClipRectMin(nonUDT_out,self)
    return nonUDT_out
end
function ImDrawList.__new(ctype,shared_data)
    local ptr = lib.ImDrawList_ImDrawList(shared_data)
    return ffi.gc(ptr,lib.ImDrawList_destroy)
end
function ImDrawList:PathArcTo(center,radius,a_min,a_max,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_PathArcTo(self,center,radius,a_min,a_max,num_segments)
end
ImDrawList.PathArcToFast = lib.ImDrawList_PathArcToFast
function ImDrawList:PathBezierCubicCurveTo(p2,p3,p4,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_PathBezierCubicCurveTo(self,p2,p3,p4,num_segments)
end
function ImDrawList:PathBezierQuadraticCurveTo(p2,p3,num_segments)
    num_segments = num_segments or 0
    return lib.ImDrawList_PathBezierQuadraticCurveTo(self,p2,p3,num_segments)
end
ImDrawList.PathClear = lib.ImDrawList_PathClear
ImDrawList.PathFillConvex = lib.ImDrawList_PathFillConvex
ImDrawList.PathLineTo = lib.ImDrawList_PathLineTo
ImDrawList.PathLineToMergeDuplicate = lib.ImDrawList_PathLineToMergeDuplicate
function ImDrawList:PathRect(rect_min,rect_max,rounding,flags)
    flags = flags or 0
    rounding = rounding or 0.0
    return lib.ImDrawList_PathRect(self,rect_min,rect_max,rounding,flags)
end
function ImDrawList:PathStroke(col,flags,thickness)
    flags = flags or 0
    thickness = thickness or 1.0
    return lib.ImDrawList_PathStroke(self,col,flags,thickness)
end
ImDrawList.PopClipRect = lib.ImDrawList_PopClipRect
ImDrawList.PopTextureID = lib.ImDrawList_PopTextureID
ImDrawList.PrimQuadUV = lib.ImDrawList_PrimQuadUV
ImDrawList.PrimRect = lib.ImDrawList_PrimRect
ImDrawList.PrimRectUV = lib.ImDrawList_PrimRectUV
ImDrawList.PrimReserve = lib.ImDrawList_PrimReserve
ImDrawList.PrimUnreserve = lib.ImDrawList_PrimUnreserve
ImDrawList.PrimVtx = lib.ImDrawList_PrimVtx
ImDrawList.PrimWriteIdx = lib.ImDrawList_PrimWriteIdx
ImDrawList.PrimWriteVtx = lib.ImDrawList_PrimWriteVtx
function ImDrawList:PushClipRect(clip_rect_min,clip_rect_max,intersect_with_current_clip_rect)
    intersect_with_current_clip_rect = intersect_with_current_clip_rect or false
    return lib.ImDrawList_PushClipRect(self,clip_rect_min,clip_rect_max,intersect_with_current_clip_rect)
end
ImDrawList.PushClipRectFullScreen = lib.ImDrawList_PushClipRectFullScreen
ImDrawList.PushTextureID = lib.ImDrawList_PushTextureID
ImDrawList._CalcCircleAutoSegmentCount = lib.ImDrawList__CalcCircleAutoSegmentCount
ImDrawList._ClearFreeMemory = lib.ImDrawList__ClearFreeMemory
ImDrawList._OnChangedClipRect = lib.ImDrawList__OnChangedClipRect
ImDrawList._OnChangedTextureID = lib.ImDrawList__OnChangedTextureID
ImDrawList._OnChangedVtxOffset = lib.ImDrawList__OnChangedVtxOffset
ImDrawList._PathArcToFastEx = lib.ImDrawList__PathArcToFastEx
ImDrawList._PathArcToN = lib.ImDrawList__PathArcToN
ImDrawList._PopUnusedDrawCmd = lib.ImDrawList__PopUnusedDrawCmd
ImDrawList._ResetForNewFrame = lib.ImDrawList__ResetForNewFrame
ImDrawList._TryMergeDrawCmds = lib.ImDrawList__TryMergeDrawCmds
M.ImDrawList = ffi.metatype("ImDrawList",ImDrawList)
--------------------------ImDrawListSharedData----------------------------
local ImDrawListSharedData= {}
ImDrawListSharedData.__index = ImDrawListSharedData
function ImDrawListSharedData.__new(ctype)
    local ptr = lib.ImDrawListSharedData_ImDrawListSharedData()
    return ffi.gc(ptr,lib.ImDrawListSharedData_destroy)
end
ImDrawListSharedData.SetCircleTessellationMaxError = lib.ImDrawListSharedData_SetCircleTessellationMaxError
M.ImDrawListSharedData = ffi.metatype("ImDrawListSharedData",ImDrawListSharedData)
--------------------------ImDrawListSplitter----------------------------
local ImDrawListSplitter= {}
ImDrawListSplitter.__index = ImDrawListSplitter
ImDrawListSplitter.Clear = lib.ImDrawListSplitter_Clear
ImDrawListSplitter.ClearFreeMemory = lib.ImDrawListSplitter_ClearFreeMemory
function ImDrawListSplitter.__new(ctype)
    local ptr = lib.ImDrawListSplitter_ImDrawListSplitter()
    return ffi.gc(ptr,lib.ImDrawListSplitter_destroy)
end
ImDrawListSplitter.Merge = lib.ImDrawListSplitter_Merge
ImDrawListSplitter.SetCurrentChannel = lib.ImDrawListSplitter_SetCurrentChannel
ImDrawListSplitter.Split = lib.ImDrawListSplitter_Split
M.ImDrawListSplitter = ffi.metatype("ImDrawListSplitter",ImDrawListSplitter)
--------------------------ImFont----------------------------
local ImFont= {}
ImFont.__index = ImFont
ImFont.AddGlyph = lib.ImFont_AddGlyph
function ImFont:AddRemapChar(dst,src,overwrite_dst)
    if overwrite_dst == nil then overwrite_dst = true end
    return lib.ImFont_AddRemapChar(self,dst,src,overwrite_dst)
end
ImFont.BuildLookupTable = lib.ImFont_BuildLookupTable
function ImFont:CalcTextSizeA(size,max_width,wrap_width,text_begin,text_end,remaining)
    remaining = remaining or nil
    text_end = text_end or nil
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImFont_CalcTextSizeA(nonUDT_out,self,size,max_width,wrap_width,text_begin,text_end,remaining)
    return nonUDT_out
end
ImFont.CalcWordWrapPositionA = lib.ImFont_CalcWordWrapPositionA
ImFont.ClearOutputData = lib.ImFont_ClearOutputData
ImFont.FindGlyph = lib.ImFont_FindGlyph
ImFont.FindGlyphNoFallback = lib.ImFont_FindGlyphNoFallback
ImFont.GetCharAdvance = lib.ImFont_GetCharAdvance
ImFont.GetDebugName = lib.ImFont_GetDebugName
ImFont.GrowIndex = lib.ImFont_GrowIndex
function ImFont.__new(ctype)
    local ptr = lib.ImFont_ImFont()
    return ffi.gc(ptr,lib.ImFont_destroy)
end
ImFont.IsGlyphRangeUnused = lib.ImFont_IsGlyphRangeUnused
ImFont.IsLoaded = lib.ImFont_IsLoaded
ImFont.RenderChar = lib.ImFont_RenderChar
function ImFont:RenderText(draw_list,size,pos,col,clip_rect,text_begin,text_end,wrap_width,cpu_fine_clip)
    cpu_fine_clip = cpu_fine_clip or false
    wrap_width = wrap_width or 0.0
    return lib.ImFont_RenderText(self,draw_list,size,pos,col,clip_rect,text_begin,text_end,wrap_width,cpu_fine_clip)
end
ImFont.SetGlyphVisible = lib.ImFont_SetGlyphVisible
M.ImFont = ffi.metatype("ImFont",ImFont)
--------------------------ImFontAtlas----------------------------
local ImFontAtlas= {}
ImFontAtlas.__index = ImFontAtlas
function ImFontAtlas:AddCustomRectFontGlyph(font,id,width,height,advance_x,offset)
    offset = offset or ImVec2(0,0)
    return lib.ImFontAtlas_AddCustomRectFontGlyph(self,font,id,width,height,advance_x,offset)
end
ImFontAtlas.AddCustomRectRegular = lib.ImFontAtlas_AddCustomRectRegular
ImFontAtlas.AddFont = lib.ImFontAtlas_AddFont
function ImFontAtlas:AddFontDefault(font_cfg)
    font_cfg = font_cfg or nil
    return lib.ImFontAtlas_AddFontDefault(self,font_cfg)
end
function ImFontAtlas:AddFontFromFileTTF(filename,size_pixels,font_cfg,glyph_ranges)
    font_cfg = font_cfg or nil
    glyph_ranges = glyph_ranges or nil
    return lib.ImFontAtlas_AddFontFromFileTTF(self,filename,size_pixels,font_cfg,glyph_ranges)
end
function ImFontAtlas:AddFontFromMemoryCompressedBase85TTF(compressed_font_data_base85,size_pixels,font_cfg,glyph_ranges)
    font_cfg = font_cfg or nil
    glyph_ranges = glyph_ranges or nil
    return lib.ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self,compressed_font_data_base85,size_pixels,font_cfg,glyph_ranges)
end
function ImFontAtlas:AddFontFromMemoryCompressedTTF(compressed_font_data,compressed_font_size,size_pixels,font_cfg,glyph_ranges)
    font_cfg = font_cfg or nil
    glyph_ranges = glyph_ranges or nil
    return lib.ImFontAtlas_AddFontFromMemoryCompressedTTF(self,compressed_font_data,compressed_font_size,size_pixels,font_cfg,glyph_ranges)
end
function ImFontAtlas:AddFontFromMemoryTTF(font_data,font_size,size_pixels,font_cfg,glyph_ranges)
    font_cfg = font_cfg or nil
    glyph_ranges = glyph_ranges or nil
    return lib.ImFontAtlas_AddFontFromMemoryTTF(self,font_data,font_size,size_pixels,font_cfg,glyph_ranges)
end
ImFontAtlas.Build = lib.ImFontAtlas_Build
ImFontAtlas.CalcCustomRectUV = lib.ImFontAtlas_CalcCustomRectUV
ImFontAtlas.Clear = lib.ImFontAtlas_Clear
ImFontAtlas.ClearFonts = lib.ImFontAtlas_ClearFonts
ImFontAtlas.ClearInputData = lib.ImFontAtlas_ClearInputData
ImFontAtlas.ClearTexData = lib.ImFontAtlas_ClearTexData
ImFontAtlas.GetCustomRectByIndex = lib.ImFontAtlas_GetCustomRectByIndex
ImFontAtlas.GetGlyphRangesChineseFull = lib.ImFontAtlas_GetGlyphRangesChineseFull
ImFontAtlas.GetGlyphRangesChineseSimplifiedCommon = lib.ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon
ImFontAtlas.GetGlyphRangesChineseSimplifiedOfficial = lib.ImFontAtlas_GetGlyphRangesChineseSimplifiedOfficial
ImFontAtlas.GetGlyphRangesCyrillic = lib.ImFontAtlas_GetGlyphRangesCyrillic
ImFontAtlas.GetGlyphRangesDefault = lib.ImFontAtlas_GetGlyphRangesDefault
ImFontAtlas.GetGlyphRangesJapanese = lib.ImFontAtlas_GetGlyphRangesJapanese
ImFontAtlas.GetGlyphRangesKorean = lib.ImFontAtlas_GetGlyphRangesKorean
ImFontAtlas.GetGlyphRangesThai = lib.ImFontAtlas_GetGlyphRangesThai
ImFontAtlas.GetGlyphRangesVietnamese = lib.ImFontAtlas_GetGlyphRangesVietnamese
ImFontAtlas.GetMouseCursorTexData = lib.ImFontAtlas_GetMouseCursorTexData
function ImFontAtlas:GetTexDataAsAlpha8(out_pixels,out_width,out_height,out_bytes_per_pixel)
    out_bytes_per_pixel = out_bytes_per_pixel or nil
    return lib.ImFontAtlas_GetTexDataAsAlpha8(self,out_pixels,out_width,out_height,out_bytes_per_pixel)
end
function ImFontAtlas:GetTexDataAsRGBA32(out_pixels,out_width,out_height,out_bytes_per_pixel)
    out_bytes_per_pixel = out_bytes_per_pixel or nil
    return lib.ImFontAtlas_GetTexDataAsRGBA32(self,out_pixels,out_width,out_height,out_bytes_per_pixel)
end
function ImFontAtlas.__new(ctype)
    local ptr = lib.ImFontAtlas_ImFontAtlas()
    return ffi.gc(ptr,lib.ImFontAtlas_destroy)
end
ImFontAtlas.IsBuilt = lib.ImFontAtlas_IsBuilt
ImFontAtlas.SetTexID = lib.ImFontAtlas_SetTexID
M.ImFontAtlas = ffi.metatype("ImFontAtlas",ImFontAtlas)
--------------------------ImFontAtlasCustomRect----------------------------
local ImFontAtlasCustomRect= {}
ImFontAtlasCustomRect.__index = ImFontAtlasCustomRect
function ImFontAtlasCustomRect.__new(ctype)
    local ptr = lib.ImFontAtlasCustomRect_ImFontAtlasCustomRect()
    return ffi.gc(ptr,lib.ImFontAtlasCustomRect_destroy)
end
ImFontAtlasCustomRect.IsPacked = lib.ImFontAtlasCustomRect_IsPacked
M.ImFontAtlasCustomRect = ffi.metatype("ImFontAtlasCustomRect",ImFontAtlasCustomRect)
--------------------------ImFontConfig----------------------------
local ImFontConfig= {}
ImFontConfig.__index = ImFontConfig
function ImFontConfig.__new(ctype)
    local ptr = lib.ImFontConfig_ImFontConfig()
    return ffi.gc(ptr,lib.ImFontConfig_destroy)
end
M.ImFontConfig = ffi.metatype("ImFontConfig",ImFontConfig)
--------------------------ImFontGlyphRangesBuilder----------------------------
local ImFontGlyphRangesBuilder= {}
ImFontGlyphRangesBuilder.__index = ImFontGlyphRangesBuilder
ImFontGlyphRangesBuilder.AddChar = lib.ImFontGlyphRangesBuilder_AddChar
ImFontGlyphRangesBuilder.AddRanges = lib.ImFontGlyphRangesBuilder_AddRanges
function ImFontGlyphRangesBuilder:AddText(text,text_end)
    text_end = text_end or nil
    return lib.ImFontGlyphRangesBuilder_AddText(self,text,text_end)
end
ImFontGlyphRangesBuilder.BuildRanges = lib.ImFontGlyphRangesBuilder_BuildRanges
ImFontGlyphRangesBuilder.Clear = lib.ImFontGlyphRangesBuilder_Clear
ImFontGlyphRangesBuilder.GetBit = lib.ImFontGlyphRangesBuilder_GetBit
function ImFontGlyphRangesBuilder.__new(ctype)
    local ptr = lib.ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder()
    return ffi.gc(ptr,lib.ImFontGlyphRangesBuilder_destroy)
end
ImFontGlyphRangesBuilder.SetBit = lib.ImFontGlyphRangesBuilder_SetBit
M.ImFontGlyphRangesBuilder = ffi.metatype("ImFontGlyphRangesBuilder",ImFontGlyphRangesBuilder)
--------------------------ImGuiComboPreviewData----------------------------
local ImGuiComboPreviewData= {}
ImGuiComboPreviewData.__index = ImGuiComboPreviewData
function ImGuiComboPreviewData.__new(ctype)
    local ptr = lib.ImGuiComboPreviewData_ImGuiComboPreviewData()
    return ffi.gc(ptr,lib.ImGuiComboPreviewData_destroy)
end
M.ImGuiComboPreviewData = ffi.metatype("ImGuiComboPreviewData",ImGuiComboPreviewData)
--------------------------ImGuiContext----------------------------
local ImGuiContext= {}
ImGuiContext.__index = ImGuiContext
function ImGuiContext.__new(ctype,shared_font_atlas)
    local ptr = lib.ImGuiContext_ImGuiContext(shared_font_atlas)
    return ffi.gc(ptr,lib.ImGuiContext_destroy)
end
M.ImGuiContext = ffi.metatype("ImGuiContext",ImGuiContext)
--------------------------ImGuiContextHook----------------------------
local ImGuiContextHook= {}
ImGuiContextHook.__index = ImGuiContextHook
function ImGuiContextHook.__new(ctype)
    local ptr = lib.ImGuiContextHook_ImGuiContextHook()
    return ffi.gc(ptr,lib.ImGuiContextHook_destroy)
end
M.ImGuiContextHook = ffi.metatype("ImGuiContextHook",ImGuiContextHook)
--------------------------ImGuiDockContext----------------------------
local ImGuiDockContext= {}
ImGuiDockContext.__index = ImGuiDockContext
function ImGuiDockContext.__new(ctype)
    local ptr = lib.ImGuiDockContext_ImGuiDockContext()
    return ffi.gc(ptr,lib.ImGuiDockContext_destroy)
end
M.ImGuiDockContext = ffi.metatype("ImGuiDockContext",ImGuiDockContext)
--------------------------ImGuiDockNode----------------------------
local ImGuiDockNode= {}
ImGuiDockNode.__index = ImGuiDockNode
function ImGuiDockNode.__new(ctype,id)
    local ptr = lib.ImGuiDockNode_ImGuiDockNode(id)
    return ffi.gc(ptr,lib.ImGuiDockNode_destroy)
end
ImGuiDockNode.IsCentralNode = lib.ImGuiDockNode_IsCentralNode
ImGuiDockNode.IsDockSpace = lib.ImGuiDockNode_IsDockSpace
ImGuiDockNode.IsEmpty = lib.ImGuiDockNode_IsEmpty
ImGuiDockNode.IsFloatingNode = lib.ImGuiDockNode_IsFloatingNode
ImGuiDockNode.IsHiddenTabBar = lib.ImGuiDockNode_IsHiddenTabBar
ImGuiDockNode.IsLeafNode = lib.ImGuiDockNode_IsLeafNode
ImGuiDockNode.IsNoTabBar = lib.ImGuiDockNode_IsNoTabBar
ImGuiDockNode.IsRootNode = lib.ImGuiDockNode_IsRootNode
ImGuiDockNode.IsSplitNode = lib.ImGuiDockNode_IsSplitNode
function ImGuiDockNode:Rect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiDockNode_Rect(nonUDT_out,self)
    return nonUDT_out
end
ImGuiDockNode.SetLocalFlags = lib.ImGuiDockNode_SetLocalFlags
ImGuiDockNode.UpdateMergedFlags = lib.ImGuiDockNode_UpdateMergedFlags
M.ImGuiDockNode = ffi.metatype("ImGuiDockNode",ImGuiDockNode)
--------------------------ImGuiIO----------------------------
local ImGuiIO= {}
ImGuiIO.__index = ImGuiIO
ImGuiIO.AddFocusEvent = lib.ImGuiIO_AddFocusEvent
ImGuiIO.AddInputCharacter = lib.ImGuiIO_AddInputCharacter
ImGuiIO.AddInputCharacterUTF16 = lib.ImGuiIO_AddInputCharacterUTF16
ImGuiIO.AddInputCharactersUTF8 = lib.ImGuiIO_AddInputCharactersUTF8
ImGuiIO.AddKeyAnalogEvent = lib.ImGuiIO_AddKeyAnalogEvent
ImGuiIO.AddKeyEvent = lib.ImGuiIO_AddKeyEvent
ImGuiIO.AddMouseButtonEvent = lib.ImGuiIO_AddMouseButtonEvent
ImGuiIO.AddMousePosEvent = lib.ImGuiIO_AddMousePosEvent
ImGuiIO.AddMouseViewportEvent = lib.ImGuiIO_AddMouseViewportEvent
ImGuiIO.AddMouseWheelEvent = lib.ImGuiIO_AddMouseWheelEvent
ImGuiIO.ClearInputCharacters = lib.ImGuiIO_ClearInputCharacters
ImGuiIO.ClearInputKeys = lib.ImGuiIO_ClearInputKeys
function ImGuiIO.__new(ctype)
    local ptr = lib.ImGuiIO_ImGuiIO()
    return ffi.gc(ptr,lib.ImGuiIO_destroy)
end
ImGuiIO.SetAppAcceptingEvents = lib.ImGuiIO_SetAppAcceptingEvents
function ImGuiIO:SetKeyEventNativeData(key,native_keycode,native_scancode,native_legacy_index)
    native_legacy_index = native_legacy_index or -1
    return lib.ImGuiIO_SetKeyEventNativeData(self,key,native_keycode,native_scancode,native_legacy_index)
end
M.ImGuiIO = ffi.metatype("ImGuiIO",ImGuiIO)
--------------------------ImGuiInputEvent----------------------------
local ImGuiInputEvent= {}
ImGuiInputEvent.__index = ImGuiInputEvent
function ImGuiInputEvent.__new(ctype)
    local ptr = lib.ImGuiInputEvent_ImGuiInputEvent()
    return ffi.gc(ptr,lib.ImGuiInputEvent_destroy)
end
M.ImGuiInputEvent = ffi.metatype("ImGuiInputEvent",ImGuiInputEvent)
--------------------------ImGuiInputTextCallbackData----------------------------
local ImGuiInputTextCallbackData= {}
ImGuiInputTextCallbackData.__index = ImGuiInputTextCallbackData
ImGuiInputTextCallbackData.ClearSelection = lib.ImGuiInputTextCallbackData_ClearSelection
ImGuiInputTextCallbackData.DeleteChars = lib.ImGuiInputTextCallbackData_DeleteChars
ImGuiInputTextCallbackData.HasSelection = lib.ImGuiInputTextCallbackData_HasSelection
function ImGuiInputTextCallbackData.__new(ctype)
    local ptr = lib.ImGuiInputTextCallbackData_ImGuiInputTextCallbackData()
    return ffi.gc(ptr,lib.ImGuiInputTextCallbackData_destroy)
end
function ImGuiInputTextCallbackData:InsertChars(pos,text,text_end)
    text_end = text_end or nil
    return lib.ImGuiInputTextCallbackData_InsertChars(self,pos,text,text_end)
end
ImGuiInputTextCallbackData.SelectAll = lib.ImGuiInputTextCallbackData_SelectAll
M.ImGuiInputTextCallbackData = ffi.metatype("ImGuiInputTextCallbackData",ImGuiInputTextCallbackData)
--------------------------ImGuiInputTextState----------------------------
local ImGuiInputTextState= {}
ImGuiInputTextState.__index = ImGuiInputTextState
ImGuiInputTextState.ClearFreeMemory = lib.ImGuiInputTextState_ClearFreeMemory
ImGuiInputTextState.ClearSelection = lib.ImGuiInputTextState_ClearSelection
ImGuiInputTextState.ClearText = lib.ImGuiInputTextState_ClearText
ImGuiInputTextState.CursorAnimReset = lib.ImGuiInputTextState_CursorAnimReset
ImGuiInputTextState.CursorClamp = lib.ImGuiInputTextState_CursorClamp
ImGuiInputTextState.GetCursorPos = lib.ImGuiInputTextState_GetCursorPos
ImGuiInputTextState.GetRedoAvailCount = lib.ImGuiInputTextState_GetRedoAvailCount
ImGuiInputTextState.GetSelectionEnd = lib.ImGuiInputTextState_GetSelectionEnd
ImGuiInputTextState.GetSelectionStart = lib.ImGuiInputTextState_GetSelectionStart
ImGuiInputTextState.GetUndoAvailCount = lib.ImGuiInputTextState_GetUndoAvailCount
ImGuiInputTextState.HasSelection = lib.ImGuiInputTextState_HasSelection
function ImGuiInputTextState.__new(ctype)
    local ptr = lib.ImGuiInputTextState_ImGuiInputTextState()
    return ffi.gc(ptr,lib.ImGuiInputTextState_destroy)
end
ImGuiInputTextState.OnKeyPressed = lib.ImGuiInputTextState_OnKeyPressed
ImGuiInputTextState.SelectAll = lib.ImGuiInputTextState_SelectAll
M.ImGuiInputTextState = ffi.metatype("ImGuiInputTextState",ImGuiInputTextState)
--------------------------ImGuiLastItemData----------------------------
local ImGuiLastItemData= {}
ImGuiLastItemData.__index = ImGuiLastItemData
function ImGuiLastItemData.__new(ctype)
    local ptr = lib.ImGuiLastItemData_ImGuiLastItemData()
    return ffi.gc(ptr,lib.ImGuiLastItemData_destroy)
end
M.ImGuiLastItemData = ffi.metatype("ImGuiLastItemData",ImGuiLastItemData)
--------------------------ImGuiListClipper----------------------------
local ImGuiListClipper= {}
ImGuiListClipper.__index = ImGuiListClipper
function ImGuiListClipper:Begin(items_count,items_height)
    items_height = items_height or -1.0
    return lib.ImGuiListClipper_Begin(self,items_count,items_height)
end
ImGuiListClipper.End = lib.ImGuiListClipper_End
ImGuiListClipper.ForceDisplayRangeByIndices = lib.ImGuiListClipper_ForceDisplayRangeByIndices
function ImGuiListClipper.__new(ctype)
    local ptr = lib.ImGuiListClipper_ImGuiListClipper()
    return ffi.gc(ptr,lib.ImGuiListClipper_destroy)
end
ImGuiListClipper.Step = lib.ImGuiListClipper_Step
M.ImGuiListClipper = ffi.metatype("ImGuiListClipper",ImGuiListClipper)
--------------------------ImGuiListClipperData----------------------------
local ImGuiListClipperData= {}
ImGuiListClipperData.__index = ImGuiListClipperData
function ImGuiListClipperData.__new(ctype)
    local ptr = lib.ImGuiListClipperData_ImGuiListClipperData()
    return ffi.gc(ptr,lib.ImGuiListClipperData_destroy)
end
ImGuiListClipperData.Reset = lib.ImGuiListClipperData_Reset
M.ImGuiListClipperData = ffi.metatype("ImGuiListClipperData",ImGuiListClipperData)
--------------------------ImGuiListClipperRange----------------------------
local ImGuiListClipperRange= {}
ImGuiListClipperRange.__index = ImGuiListClipperRange
M.ImGuiListClipperRange_FromIndices = lib.ImGuiListClipperRange_FromIndices
M.ImGuiListClipperRange_FromPositions = lib.ImGuiListClipperRange_FromPositions
M.ImGuiListClipperRange = ffi.metatype("ImGuiListClipperRange",ImGuiListClipperRange)
--------------------------ImGuiMenuColumns----------------------------
local ImGuiMenuColumns= {}
ImGuiMenuColumns.__index = ImGuiMenuColumns
ImGuiMenuColumns.CalcNextTotalWidth = lib.ImGuiMenuColumns_CalcNextTotalWidth
ImGuiMenuColumns.DeclColumns = lib.ImGuiMenuColumns_DeclColumns
function ImGuiMenuColumns.__new(ctype)
    local ptr = lib.ImGuiMenuColumns_ImGuiMenuColumns()
    return ffi.gc(ptr,lib.ImGuiMenuColumns_destroy)
end
ImGuiMenuColumns.Update = lib.ImGuiMenuColumns_Update
M.ImGuiMenuColumns = ffi.metatype("ImGuiMenuColumns",ImGuiMenuColumns)
--------------------------ImGuiMetricsConfig----------------------------
local ImGuiMetricsConfig= {}
ImGuiMetricsConfig.__index = ImGuiMetricsConfig
function ImGuiMetricsConfig.__new(ctype)
    local ptr = lib.ImGuiMetricsConfig_ImGuiMetricsConfig()
    return ffi.gc(ptr,lib.ImGuiMetricsConfig_destroy)
end
M.ImGuiMetricsConfig = ffi.metatype("ImGuiMetricsConfig",ImGuiMetricsConfig)
--------------------------ImGuiNavItemData----------------------------
local ImGuiNavItemData= {}
ImGuiNavItemData.__index = ImGuiNavItemData
ImGuiNavItemData.Clear = lib.ImGuiNavItemData_Clear
function ImGuiNavItemData.__new(ctype)
    local ptr = lib.ImGuiNavItemData_ImGuiNavItemData()
    return ffi.gc(ptr,lib.ImGuiNavItemData_destroy)
end
M.ImGuiNavItemData = ffi.metatype("ImGuiNavItemData",ImGuiNavItemData)
--------------------------ImGuiNextItemData----------------------------
local ImGuiNextItemData= {}
ImGuiNextItemData.__index = ImGuiNextItemData
ImGuiNextItemData.ClearFlags = lib.ImGuiNextItemData_ClearFlags
function ImGuiNextItemData.__new(ctype)
    local ptr = lib.ImGuiNextItemData_ImGuiNextItemData()
    return ffi.gc(ptr,lib.ImGuiNextItemData_destroy)
end
M.ImGuiNextItemData = ffi.metatype("ImGuiNextItemData",ImGuiNextItemData)
--------------------------ImGuiNextWindowData----------------------------
local ImGuiNextWindowData= {}
ImGuiNextWindowData.__index = ImGuiNextWindowData
ImGuiNextWindowData.ClearFlags = lib.ImGuiNextWindowData_ClearFlags
function ImGuiNextWindowData.__new(ctype)
    local ptr = lib.ImGuiNextWindowData_ImGuiNextWindowData()
    return ffi.gc(ptr,lib.ImGuiNextWindowData_destroy)
end
M.ImGuiNextWindowData = ffi.metatype("ImGuiNextWindowData",ImGuiNextWindowData)
--------------------------ImGuiOldColumnData----------------------------
local ImGuiOldColumnData= {}
ImGuiOldColumnData.__index = ImGuiOldColumnData
function ImGuiOldColumnData.__new(ctype)
    local ptr = lib.ImGuiOldColumnData_ImGuiOldColumnData()
    return ffi.gc(ptr,lib.ImGuiOldColumnData_destroy)
end
M.ImGuiOldColumnData = ffi.metatype("ImGuiOldColumnData",ImGuiOldColumnData)
--------------------------ImGuiOldColumns----------------------------
local ImGuiOldColumns= {}
ImGuiOldColumns.__index = ImGuiOldColumns
function ImGuiOldColumns.__new(ctype)
    local ptr = lib.ImGuiOldColumns_ImGuiOldColumns()
    return ffi.gc(ptr,lib.ImGuiOldColumns_destroy)
end
M.ImGuiOldColumns = ffi.metatype("ImGuiOldColumns",ImGuiOldColumns)
--------------------------ImGuiOnceUponAFrame----------------------------
local ImGuiOnceUponAFrame= {}
ImGuiOnceUponAFrame.__index = ImGuiOnceUponAFrame
function ImGuiOnceUponAFrame.__new(ctype)
    local ptr = lib.ImGuiOnceUponAFrame_ImGuiOnceUponAFrame()
    return ffi.gc(ptr,lib.ImGuiOnceUponAFrame_destroy)
end
M.ImGuiOnceUponAFrame = ffi.metatype("ImGuiOnceUponAFrame",ImGuiOnceUponAFrame)
--------------------------ImGuiPayload----------------------------
local ImGuiPayload= {}
ImGuiPayload.__index = ImGuiPayload
ImGuiPayload.Clear = lib.ImGuiPayload_Clear
function ImGuiPayload.__new(ctype)
    local ptr = lib.ImGuiPayload_ImGuiPayload()
    return ffi.gc(ptr,lib.ImGuiPayload_destroy)
end
ImGuiPayload.IsDataType = lib.ImGuiPayload_IsDataType
ImGuiPayload.IsDelivery = lib.ImGuiPayload_IsDelivery
ImGuiPayload.IsPreview = lib.ImGuiPayload_IsPreview
M.ImGuiPayload = ffi.metatype("ImGuiPayload",ImGuiPayload)
--------------------------ImGuiPlatformIO----------------------------
local ImGuiPlatformIO= {}
ImGuiPlatformIO.__index = ImGuiPlatformIO
function ImGuiPlatformIO.__new(ctype)
    local ptr = lib.ImGuiPlatformIO_ImGuiPlatformIO()
    return ffi.gc(ptr,lib.ImGuiPlatformIO_destroy)
end
M.ImGuiPlatformIO = ffi.metatype("ImGuiPlatformIO",ImGuiPlatformIO)
--------------------------ImGuiPlatformImeData----------------------------
local ImGuiPlatformImeData= {}
ImGuiPlatformImeData.__index = ImGuiPlatformImeData
function ImGuiPlatformImeData.__new(ctype)
    local ptr = lib.ImGuiPlatformImeData_ImGuiPlatformImeData()
    return ffi.gc(ptr,lib.ImGuiPlatformImeData_destroy)
end
M.ImGuiPlatformImeData = ffi.metatype("ImGuiPlatformImeData",ImGuiPlatformImeData)
--------------------------ImGuiPlatformMonitor----------------------------
local ImGuiPlatformMonitor= {}
ImGuiPlatformMonitor.__index = ImGuiPlatformMonitor
function ImGuiPlatformMonitor.__new(ctype)
    local ptr = lib.ImGuiPlatformMonitor_ImGuiPlatformMonitor()
    return ffi.gc(ptr,lib.ImGuiPlatformMonitor_destroy)
end
M.ImGuiPlatformMonitor = ffi.metatype("ImGuiPlatformMonitor",ImGuiPlatformMonitor)
--------------------------ImGuiPopupData----------------------------
local ImGuiPopupData= {}
ImGuiPopupData.__index = ImGuiPopupData
function ImGuiPopupData.__new(ctype)
    local ptr = lib.ImGuiPopupData_ImGuiPopupData()
    return ffi.gc(ptr,lib.ImGuiPopupData_destroy)
end
M.ImGuiPopupData = ffi.metatype("ImGuiPopupData",ImGuiPopupData)
--------------------------ImGuiPtrOrIndex----------------------------
local ImGuiPtrOrIndex= {}
ImGuiPtrOrIndex.__index = ImGuiPtrOrIndex
function ImGuiPtrOrIndex.ImGuiPtrOrIndex_Ptr(ptr)
    local ptr = lib.ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(ptr)
    return ffi.gc(ptr,lib.ImGuiPtrOrIndex_destroy)
end
function ImGuiPtrOrIndex.ImGuiPtrOrIndex_Int(index)
    local ptr = lib.ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(index)
    return ffi.gc(ptr,lib.ImGuiPtrOrIndex_destroy)
end
function ImGuiPtrOrIndex.__new(ctype,a1) -- generic version
    if ffi.istype('void*',a1) then return ImGuiPtrOrIndex.ImGuiPtrOrIndex_Ptr(a1) end
    if (ffi.istype('int',a1) or type(a1)=='number') then return ImGuiPtrOrIndex.ImGuiPtrOrIndex_Int(a1) end
    print(ctype,a1)
    error'ImGuiPtrOrIndex.__new could not find overloaded'
end
M.ImGuiPtrOrIndex = ffi.metatype("ImGuiPtrOrIndex",ImGuiPtrOrIndex)
--------------------------ImGuiSettingsHandler----------------------------
local ImGuiSettingsHandler= {}
ImGuiSettingsHandler.__index = ImGuiSettingsHandler
function ImGuiSettingsHandler.__new(ctype)
    local ptr = lib.ImGuiSettingsHandler_ImGuiSettingsHandler()
    return ffi.gc(ptr,lib.ImGuiSettingsHandler_destroy)
end
M.ImGuiSettingsHandler = ffi.metatype("ImGuiSettingsHandler",ImGuiSettingsHandler)
--------------------------ImGuiStackLevelInfo----------------------------
local ImGuiStackLevelInfo= {}
ImGuiStackLevelInfo.__index = ImGuiStackLevelInfo
function ImGuiStackLevelInfo.__new(ctype)
    local ptr = lib.ImGuiStackLevelInfo_ImGuiStackLevelInfo()
    return ffi.gc(ptr,lib.ImGuiStackLevelInfo_destroy)
end
M.ImGuiStackLevelInfo = ffi.metatype("ImGuiStackLevelInfo",ImGuiStackLevelInfo)
--------------------------ImGuiStackSizes----------------------------
local ImGuiStackSizes= {}
ImGuiStackSizes.__index = ImGuiStackSizes
ImGuiStackSizes.CompareWithCurrentState = lib.ImGuiStackSizes_CompareWithCurrentState
function ImGuiStackSizes.__new(ctype)
    local ptr = lib.ImGuiStackSizes_ImGuiStackSizes()
    return ffi.gc(ptr,lib.ImGuiStackSizes_destroy)
end
ImGuiStackSizes.SetToCurrentState = lib.ImGuiStackSizes_SetToCurrentState
M.ImGuiStackSizes = ffi.metatype("ImGuiStackSizes",ImGuiStackSizes)
--------------------------ImGuiStackTool----------------------------
local ImGuiStackTool= {}
ImGuiStackTool.__index = ImGuiStackTool
function ImGuiStackTool.__new(ctype)
    local ptr = lib.ImGuiStackTool_ImGuiStackTool()
    return ffi.gc(ptr,lib.ImGuiStackTool_destroy)
end
M.ImGuiStackTool = ffi.metatype("ImGuiStackTool",ImGuiStackTool)
--------------------------ImGuiStorage----------------------------
local ImGuiStorage= {}
ImGuiStorage.__index = ImGuiStorage
ImGuiStorage.BuildSortByKey = lib.ImGuiStorage_BuildSortByKey
ImGuiStorage.Clear = lib.ImGuiStorage_Clear
function ImGuiStorage:GetBool(key,default_val)
    default_val = default_val or false
    return lib.ImGuiStorage_GetBool(self,key,default_val)
end
function ImGuiStorage:GetBoolRef(key,default_val)
    default_val = default_val or false
    return lib.ImGuiStorage_GetBoolRef(self,key,default_val)
end
function ImGuiStorage:GetFloat(key,default_val)
    default_val = default_val or 0.0
    return lib.ImGuiStorage_GetFloat(self,key,default_val)
end
function ImGuiStorage:GetFloatRef(key,default_val)
    default_val = default_val or 0.0
    return lib.ImGuiStorage_GetFloatRef(self,key,default_val)
end
function ImGuiStorage:GetInt(key,default_val)
    default_val = default_val or 0
    return lib.ImGuiStorage_GetInt(self,key,default_val)
end
function ImGuiStorage:GetIntRef(key,default_val)
    default_val = default_val or 0
    return lib.ImGuiStorage_GetIntRef(self,key,default_val)
end
ImGuiStorage.GetVoidPtr = lib.ImGuiStorage_GetVoidPtr
function ImGuiStorage:GetVoidPtrRef(key,default_val)
    default_val = default_val or nil
    return lib.ImGuiStorage_GetVoidPtrRef(self,key,default_val)
end
ImGuiStorage.SetAllInt = lib.ImGuiStorage_SetAllInt
ImGuiStorage.SetBool = lib.ImGuiStorage_SetBool
ImGuiStorage.SetFloat = lib.ImGuiStorage_SetFloat
ImGuiStorage.SetInt = lib.ImGuiStorage_SetInt
ImGuiStorage.SetVoidPtr = lib.ImGuiStorage_SetVoidPtr
M.ImGuiStorage = ffi.metatype("ImGuiStorage",ImGuiStorage)
--------------------------ImGuiStoragePair----------------------------
local ImGuiStoragePair= {}
ImGuiStoragePair.__index = ImGuiStoragePair
function ImGuiStoragePair.ImGuiStoragePair_Int(_key,_val_i)
    local ptr = lib.ImGuiStoragePair_ImGuiStoragePair_Int(_key,_val_i)
    return ffi.gc(ptr,lib.ImGuiStoragePair_destroy)
end
function ImGuiStoragePair.ImGuiStoragePair_Float(_key,_val_f)
    local ptr = lib.ImGuiStoragePair_ImGuiStoragePair_Float(_key,_val_f)
    return ffi.gc(ptr,lib.ImGuiStoragePair_destroy)
end
function ImGuiStoragePair.ImGuiStoragePair_Ptr(_key,_val_p)
    local ptr = lib.ImGuiStoragePair_ImGuiStoragePair_Ptr(_key,_val_p)
    return ffi.gc(ptr,lib.ImGuiStoragePair_destroy)
end
function ImGuiStoragePair.__new(ctype,a1,a2) -- generic version
    if (ffi.istype('int',a2) or type(a2)=='number') then return ImGuiStoragePair.ImGuiStoragePair_Int(a1,a2) end
    if (ffi.istype('float',a2) or type(a2)=='number') then return ImGuiStoragePair.ImGuiStoragePair_Float(a1,a2) end
    if ffi.istype('void*',a2) then return ImGuiStoragePair.ImGuiStoragePair_Ptr(a1,a2) end
    print(ctype,a1,a2)
    error'ImGuiStoragePair.__new could not find overloaded'
end
M.ImGuiStoragePair = ffi.metatype("ImGuiStoragePair",ImGuiStoragePair)
--------------------------ImGuiStyle----------------------------
local ImGuiStyle= {}
ImGuiStyle.__index = ImGuiStyle
function ImGuiStyle.__new(ctype)
    local ptr = lib.ImGuiStyle_ImGuiStyle()
    return ffi.gc(ptr,lib.ImGuiStyle_destroy)
end
ImGuiStyle.ScaleAllSizes = lib.ImGuiStyle_ScaleAllSizes
M.ImGuiStyle = ffi.metatype("ImGuiStyle",ImGuiStyle)
--------------------------ImGuiStyleMod----------------------------
local ImGuiStyleMod= {}
ImGuiStyleMod.__index = ImGuiStyleMod
function ImGuiStyleMod.ImGuiStyleMod_Int(idx,v)
    local ptr = lib.ImGuiStyleMod_ImGuiStyleMod_Int(idx,v)
    return ffi.gc(ptr,lib.ImGuiStyleMod_destroy)
end
function ImGuiStyleMod.ImGuiStyleMod_Float(idx,v)
    local ptr = lib.ImGuiStyleMod_ImGuiStyleMod_Float(idx,v)
    return ffi.gc(ptr,lib.ImGuiStyleMod_destroy)
end
function ImGuiStyleMod.ImGuiStyleMod_Vec2(idx,v)
    local ptr = lib.ImGuiStyleMod_ImGuiStyleMod_Vec2(idx,v)
    return ffi.gc(ptr,lib.ImGuiStyleMod_destroy)
end
function ImGuiStyleMod.__new(ctype,a1,a2) -- generic version
    if (ffi.istype('int',a2) or type(a2)=='number') then return ImGuiStyleMod.ImGuiStyleMod_Int(a1,a2) end
    if (ffi.istype('float',a2) or type(a2)=='number') then return ImGuiStyleMod.ImGuiStyleMod_Float(a1,a2) end
    if ffi.istype('ImVec2',a2) then return ImGuiStyleMod.ImGuiStyleMod_Vec2(a1,a2) end
    print(ctype,a1,a2)
    error'ImGuiStyleMod.__new could not find overloaded'
end
M.ImGuiStyleMod = ffi.metatype("ImGuiStyleMod",ImGuiStyleMod)
--------------------------ImGuiTabBar----------------------------
local ImGuiTabBar= {}
ImGuiTabBar.__index = ImGuiTabBar
ImGuiTabBar.GetTabName = lib.ImGuiTabBar_GetTabName
ImGuiTabBar.GetTabOrder = lib.ImGuiTabBar_GetTabOrder
function ImGuiTabBar.__new(ctype)
    local ptr = lib.ImGuiTabBar_ImGuiTabBar()
    return ffi.gc(ptr,lib.ImGuiTabBar_destroy)
end
M.ImGuiTabBar = ffi.metatype("ImGuiTabBar",ImGuiTabBar)
--------------------------ImGuiTabItem----------------------------
local ImGuiTabItem= {}
ImGuiTabItem.__index = ImGuiTabItem
function ImGuiTabItem.__new(ctype)
    local ptr = lib.ImGuiTabItem_ImGuiTabItem()
    return ffi.gc(ptr,lib.ImGuiTabItem_destroy)
end
M.ImGuiTabItem = ffi.metatype("ImGuiTabItem",ImGuiTabItem)
--------------------------ImGuiTable----------------------------
local ImGuiTable= {}
ImGuiTable.__index = ImGuiTable
function ImGuiTable.__new(ctype)
    local ptr = lib.ImGuiTable_ImGuiTable()
    return ffi.gc(ptr,lib.ImGuiTable_destroy)
end
M.ImGuiTable = ffi.metatype("ImGuiTable",ImGuiTable)
--------------------------ImGuiTableColumn----------------------------
local ImGuiTableColumn= {}
ImGuiTableColumn.__index = ImGuiTableColumn
function ImGuiTableColumn.__new(ctype)
    local ptr = lib.ImGuiTableColumn_ImGuiTableColumn()
    return ffi.gc(ptr,lib.ImGuiTableColumn_destroy)
end
M.ImGuiTableColumn = ffi.metatype("ImGuiTableColumn",ImGuiTableColumn)
--------------------------ImGuiTableColumnSettings----------------------------
local ImGuiTableColumnSettings= {}
ImGuiTableColumnSettings.__index = ImGuiTableColumnSettings
function ImGuiTableColumnSettings.__new(ctype)
    local ptr = lib.ImGuiTableColumnSettings_ImGuiTableColumnSettings()
    return ffi.gc(ptr,lib.ImGuiTableColumnSettings_destroy)
end
M.ImGuiTableColumnSettings = ffi.metatype("ImGuiTableColumnSettings",ImGuiTableColumnSettings)
--------------------------ImGuiTableColumnSortSpecs----------------------------
local ImGuiTableColumnSortSpecs= {}
ImGuiTableColumnSortSpecs.__index = ImGuiTableColumnSortSpecs
function ImGuiTableColumnSortSpecs.__new(ctype)
    local ptr = lib.ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs()
    return ffi.gc(ptr,lib.ImGuiTableColumnSortSpecs_destroy)
end
M.ImGuiTableColumnSortSpecs = ffi.metatype("ImGuiTableColumnSortSpecs",ImGuiTableColumnSortSpecs)
--------------------------ImGuiTableInstanceData----------------------------
local ImGuiTableInstanceData= {}
ImGuiTableInstanceData.__index = ImGuiTableInstanceData
function ImGuiTableInstanceData.__new(ctype)
    local ptr = lib.ImGuiTableInstanceData_ImGuiTableInstanceData()
    return ffi.gc(ptr,lib.ImGuiTableInstanceData_destroy)
end
M.ImGuiTableInstanceData = ffi.metatype("ImGuiTableInstanceData",ImGuiTableInstanceData)
--------------------------ImGuiTableSettings----------------------------
local ImGuiTableSettings= {}
ImGuiTableSettings.__index = ImGuiTableSettings
ImGuiTableSettings.GetColumnSettings = lib.ImGuiTableSettings_GetColumnSettings
function ImGuiTableSettings.__new(ctype)
    local ptr = lib.ImGuiTableSettings_ImGuiTableSettings()
    return ffi.gc(ptr,lib.ImGuiTableSettings_destroy)
end
M.ImGuiTableSettings = ffi.metatype("ImGuiTableSettings",ImGuiTableSettings)
--------------------------ImGuiTableSortSpecs----------------------------
local ImGuiTableSortSpecs= {}
ImGuiTableSortSpecs.__index = ImGuiTableSortSpecs
function ImGuiTableSortSpecs.__new(ctype)
    local ptr = lib.ImGuiTableSortSpecs_ImGuiTableSortSpecs()
    return ffi.gc(ptr,lib.ImGuiTableSortSpecs_destroy)
end
M.ImGuiTableSortSpecs = ffi.metatype("ImGuiTableSortSpecs",ImGuiTableSortSpecs)
--------------------------ImGuiTableTempData----------------------------
local ImGuiTableTempData= {}
ImGuiTableTempData.__index = ImGuiTableTempData
function ImGuiTableTempData.__new(ctype)
    local ptr = lib.ImGuiTableTempData_ImGuiTableTempData()
    return ffi.gc(ptr,lib.ImGuiTableTempData_destroy)
end
M.ImGuiTableTempData = ffi.metatype("ImGuiTableTempData",ImGuiTableTempData)
--------------------------ImGuiTextBuffer----------------------------
local ImGuiTextBuffer= {}
ImGuiTextBuffer.__index = ImGuiTextBuffer
function ImGuiTextBuffer.__new(ctype)
    local ptr = lib.ImGuiTextBuffer_ImGuiTextBuffer()
    return ffi.gc(ptr,lib.ImGuiTextBuffer_destroy)
end
function ImGuiTextBuffer:append(str,str_end)
    str_end = str_end or nil
    return lib.ImGuiTextBuffer_append(self,str,str_end)
end
ImGuiTextBuffer.appendf = lib.ImGuiTextBuffer_appendf
ImGuiTextBuffer.appendfv = lib.ImGuiTextBuffer_appendfv
ImGuiTextBuffer.begin = lib.ImGuiTextBuffer_begin
ImGuiTextBuffer.c_str = lib.ImGuiTextBuffer_c_str
ImGuiTextBuffer.clear = lib.ImGuiTextBuffer_clear
ImGuiTextBuffer.empty = lib.ImGuiTextBuffer_empty
ImGuiTextBuffer._end = lib.ImGuiTextBuffer_end
ImGuiTextBuffer.reserve = lib.ImGuiTextBuffer_reserve
ImGuiTextBuffer.size = lib.ImGuiTextBuffer_size
M.ImGuiTextBuffer = ffi.metatype("ImGuiTextBuffer",ImGuiTextBuffer)
--------------------------ImGuiTextFilter----------------------------
local ImGuiTextFilter= {}
ImGuiTextFilter.__index = ImGuiTextFilter
ImGuiTextFilter.Build = lib.ImGuiTextFilter_Build
ImGuiTextFilter.Clear = lib.ImGuiTextFilter_Clear
function ImGuiTextFilter:Draw(label,width)
    label = label or "Filter(inc,-exc)"
    width = width or 0.0
    return lib.ImGuiTextFilter_Draw(self,label,width)
end
function ImGuiTextFilter.__new(ctype,default_filter)
    if default_filter == nil then default_filter = "" end
    local ptr = lib.ImGuiTextFilter_ImGuiTextFilter(default_filter)
    return ffi.gc(ptr,lib.ImGuiTextFilter_destroy)
end
ImGuiTextFilter.IsActive = lib.ImGuiTextFilter_IsActive
function ImGuiTextFilter:PassFilter(text,text_end)
    text_end = text_end or nil
    return lib.ImGuiTextFilter_PassFilter(self,text,text_end)
end
M.ImGuiTextFilter = ffi.metatype("ImGuiTextFilter",ImGuiTextFilter)
--------------------------ImGuiTextRange----------------------------
local ImGuiTextRange= {}
ImGuiTextRange.__index = ImGuiTextRange
function ImGuiTextRange.ImGuiTextRange_Nil()
    local ptr = lib.ImGuiTextRange_ImGuiTextRange_Nil()
    return ffi.gc(ptr,lib.ImGuiTextRange_destroy)
end
function ImGuiTextRange.ImGuiTextRange_Str(_b,_e)
    local ptr = lib.ImGuiTextRange_ImGuiTextRange_Str(_b,_e)
    return ffi.gc(ptr,lib.ImGuiTextRange_destroy)
end
function ImGuiTextRange.__new(ctype,a1,a2) -- generic version
    if a1==nil then return ImGuiTextRange.ImGuiTextRange_Nil() end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return ImGuiTextRange.ImGuiTextRange_Str(a1,a2) end
    print(ctype,a1,a2)
    error'ImGuiTextRange.__new could not find overloaded'
end
ImGuiTextRange.empty = lib.ImGuiTextRange_empty
ImGuiTextRange.split = lib.ImGuiTextRange_split
M.ImGuiTextRange = ffi.metatype("ImGuiTextRange",ImGuiTextRange)
--------------------------ImGuiViewport----------------------------
local ImGuiViewport= {}
ImGuiViewport.__index = ImGuiViewport
function ImGuiViewport:GetCenter()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImGuiViewport_GetCenter(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiViewport:GetWorkCenter()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImGuiViewport_GetWorkCenter(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiViewport.__new(ctype)
    local ptr = lib.ImGuiViewport_ImGuiViewport()
    return ffi.gc(ptr,lib.ImGuiViewport_destroy)
end
M.ImGuiViewport = ffi.metatype("ImGuiViewport",ImGuiViewport)
--------------------------ImGuiViewportP----------------------------
local ImGuiViewportP= {}
ImGuiViewportP.__index = ImGuiViewportP
function ImGuiViewportP:CalcWorkRectPos(off_min)
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImGuiViewportP_CalcWorkRectPos(nonUDT_out,self,off_min)
    return nonUDT_out
end
function ImGuiViewportP:CalcWorkRectSize(off_min,off_max)
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImGuiViewportP_CalcWorkRectSize(nonUDT_out,self,off_min,off_max)
    return nonUDT_out
end
ImGuiViewportP.ClearRequestFlags = lib.ImGuiViewportP_ClearRequestFlags
function ImGuiViewportP:GetBuildWorkRect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiViewportP_GetBuildWorkRect(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiViewportP:GetMainRect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiViewportP_GetMainRect(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiViewportP:GetWorkRect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiViewportP_GetWorkRect(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiViewportP.__new(ctype)
    local ptr = lib.ImGuiViewportP_ImGuiViewportP()
    return ffi.gc(ptr,lib.ImGuiViewportP_destroy)
end
ImGuiViewportP.UpdateWorkRect = lib.ImGuiViewportP_UpdateWorkRect
M.ImGuiViewportP = ffi.metatype("ImGuiViewportP",ImGuiViewportP)
--------------------------ImGuiWindow----------------------------
local ImGuiWindow= {}
ImGuiWindow.__index = ImGuiWindow
ImGuiWindow.CalcFontSize = lib.ImGuiWindow_CalcFontSize
function ImGuiWindow:GetID_Str(str,str_end)
    str_end = str_end or nil
    return lib.ImGuiWindow_GetID_Str(self,str,str_end)
end
ImGuiWindow.GetID_Ptr = lib.ImGuiWindow_GetID_Ptr
ImGuiWindow.GetID_Int = lib.ImGuiWindow_GetID_Int
function ImGuiWindow:GetID(a2,a3) -- generic version
    if (ffi.istype('const char*',a2) or ffi.istype('char[]',a2) or type(a2)=='string') then return self:GetID_Str(a2,a3) end
    if ffi.istype('const void*',a2) then return self:GetID_Ptr(a2) end
    if (ffi.istype('int',a2) or type(a2)=='number') then return self:GetID_Int(a2) end
    print(a2,a3)
    error'ImGuiWindow:GetID could not find overloaded'
end
ImGuiWindow.GetIDFromRectangle = lib.ImGuiWindow_GetIDFromRectangle
function ImGuiWindow.__new(ctype,context,name)
    local ptr = lib.ImGuiWindow_ImGuiWindow(context,name)
    return ffi.gc(ptr,lib.ImGuiWindow_destroy)
end
ImGuiWindow.MenuBarHeight = lib.ImGuiWindow_MenuBarHeight
function ImGuiWindow:MenuBarRect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiWindow_MenuBarRect(nonUDT_out,self)
    return nonUDT_out
end
function ImGuiWindow:Rect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiWindow_Rect(nonUDT_out,self)
    return nonUDT_out
end
ImGuiWindow.TitleBarHeight = lib.ImGuiWindow_TitleBarHeight
function ImGuiWindow:TitleBarRect()
    local nonUDT_out = ffi.new("ImRect")
    lib.ImGuiWindow_TitleBarRect(nonUDT_out,self)
    return nonUDT_out
end
M.ImGuiWindow = ffi.metatype("ImGuiWindow",ImGuiWindow)
--------------------------ImGuiWindowClass----------------------------
local ImGuiWindowClass= {}
ImGuiWindowClass.__index = ImGuiWindowClass
function ImGuiWindowClass.__new(ctype)
    local ptr = lib.ImGuiWindowClass_ImGuiWindowClass()
    return ffi.gc(ptr,lib.ImGuiWindowClass_destroy)
end
M.ImGuiWindowClass = ffi.metatype("ImGuiWindowClass",ImGuiWindowClass)
--------------------------ImGuiWindowSettings----------------------------
local ImGuiWindowSettings= {}
ImGuiWindowSettings.__index = ImGuiWindowSettings
ImGuiWindowSettings.GetName = lib.ImGuiWindowSettings_GetName
function ImGuiWindowSettings.__new(ctype)
    local ptr = lib.ImGuiWindowSettings_ImGuiWindowSettings()
    return ffi.gc(ptr,lib.ImGuiWindowSettings_destroy)
end
M.ImGuiWindowSettings = ffi.metatype("ImGuiWindowSettings",ImGuiWindowSettings)
--------------------------ImRect----------------------------
local ImRect= {}
ImRect.__index = ImRect
ImRect.Add_Vec2 = lib.ImRect_Add_Vec2
ImRect.Add_Rect = lib.ImRect_Add_Rect
function ImRect:Add(a2) -- generic version
    if ffi.istype('const ImVec2',a2) then return self:Add_Vec2(a2) end
    if ffi.istype('const ImRect',a2) then return self:Add_Rect(a2) end
    print(a2)
    error'ImRect:Add could not find overloaded'
end
ImRect.ClipWith = lib.ImRect_ClipWith
ImRect.ClipWithFull = lib.ImRect_ClipWithFull
ImRect.Contains_Vec2 = lib.ImRect_Contains_Vec2
ImRect.Contains_Rect = lib.ImRect_Contains_Rect
function ImRect:Contains(a2) -- generic version
    if ffi.istype('const ImVec2',a2) then return self:Contains_Vec2(a2) end
    if ffi.istype('const ImRect',a2) then return self:Contains_Rect(a2) end
    print(a2)
    error'ImRect:Contains could not find overloaded'
end
ImRect.Expand_Float = lib.ImRect_Expand_Float
ImRect.Expand_Vec2 = lib.ImRect_Expand_Vec2
function ImRect:Expand(a2) -- generic version
    if ffi.istype('const float',a2) then return self:Expand_Float(a2) end
    if ffi.istype('const ImVec2',a2) then return self:Expand_Vec2(a2) end
    print(a2)
    error'ImRect:Expand could not find overloaded'
end
ImRect.Floor = lib.ImRect_Floor
ImRect.GetArea = lib.ImRect_GetArea
function ImRect:GetBL()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetBL(nonUDT_out,self)
    return nonUDT_out
end
function ImRect:GetBR()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetBR(nonUDT_out,self)
    return nonUDT_out
end
function ImRect:GetCenter()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetCenter(nonUDT_out,self)
    return nonUDT_out
end
ImRect.GetHeight = lib.ImRect_GetHeight
function ImRect:GetSize()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetSize(nonUDT_out,self)
    return nonUDT_out
end
function ImRect:GetTL()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetTL(nonUDT_out,self)
    return nonUDT_out
end
function ImRect:GetTR()
    local nonUDT_out = ffi.new("ImVec2")
    lib.ImRect_GetTR(nonUDT_out,self)
    return nonUDT_out
end
ImRect.GetWidth = lib.ImRect_GetWidth
function ImRect.ImRect_Nil()
    local ptr = lib.ImRect_ImRect_Nil()
    return ffi.gc(ptr,lib.ImRect_destroy)
end
function ImRect.ImRect_Vec2(min,max)
    local ptr = lib.ImRect_ImRect_Vec2(min,max)
    return ffi.gc(ptr,lib.ImRect_destroy)
end
function ImRect.ImRect_Vec4(v)
    local ptr = lib.ImRect_ImRect_Vec4(v)
    return ffi.gc(ptr,lib.ImRect_destroy)
end
function ImRect.ImRect_Float(x1,y1,x2,y2)
    local ptr = lib.ImRect_ImRect_Float(x1,y1,x2,y2)
    return ffi.gc(ptr,lib.ImRect_destroy)
end
function ImRect.__new(ctype,a1,a2,a3,a4) -- generic version
    if a1==nil then return ImRect.ImRect_Nil() end
    if ffi.istype('const ImVec2',a1) then return ImRect.ImRect_Vec2(a1,a2) end
    if ffi.istype('const ImVec4',a1) then return ImRect.ImRect_Vec4(a1) end
    if (ffi.istype('float',a1) or type(a1)=='number') then return ImRect.ImRect_Float(a1,a2,a3,a4) end
    print(ctype,a1,a2,a3,a4)
    error'ImRect.__new could not find overloaded'
end
ImRect.IsInverted = lib.ImRect_IsInverted
ImRect.Overlaps = lib.ImRect_Overlaps
function ImRect:ToVec4()
    local nonUDT_out = ffi.new("ImVec4")
    lib.ImRect_ToVec4(nonUDT_out,self)
    return nonUDT_out
end
ImRect.Translate = lib.ImRect_Translate
ImRect.TranslateX = lib.ImRect_TranslateX
ImRect.TranslateY = lib.ImRect_TranslateY
M.ImRect = ffi.metatype("ImRect",ImRect)
--------------------------ImVec1----------------------------
local ImVec1= {}
ImVec1.__index = ImVec1
function ImVec1.ImVec1_Nil()
    local ptr = lib.ImVec1_ImVec1_Nil()
    return ffi.gc(ptr,lib.ImVec1_destroy)
end
function ImVec1.ImVec1_Float(_x)
    local ptr = lib.ImVec1_ImVec1_Float(_x)
    return ffi.gc(ptr,lib.ImVec1_destroy)
end
function ImVec1.__new(ctype,a1) -- generic version
    if a1==nil then return ImVec1.ImVec1_Nil() end
    if (ffi.istype('float',a1) or type(a1)=='number') then return ImVec1.ImVec1_Float(a1) end
    print(ctype,a1)
    error'ImVec1.__new could not find overloaded'
end
M.ImVec1 = ffi.metatype("ImVec1",ImVec1)
--------------------------ImVec2ih----------------------------
local ImVec2ih= {}
ImVec2ih.__index = ImVec2ih
function ImVec2ih.ImVec2ih_Nil()
    local ptr = lib.ImVec2ih_ImVec2ih_Nil()
    return ffi.gc(ptr,lib.ImVec2ih_destroy)
end
function ImVec2ih.ImVec2ih_short(_x,_y)
    local ptr = lib.ImVec2ih_ImVec2ih_short(_x,_y)
    return ffi.gc(ptr,lib.ImVec2ih_destroy)
end
function ImVec2ih.ImVec2ih_Vec2(rhs)
    local ptr = lib.ImVec2ih_ImVec2ih_Vec2(rhs)
    return ffi.gc(ptr,lib.ImVec2ih_destroy)
end
function ImVec2ih.__new(ctype,a1,a2) -- generic version
    if a1==nil then return ImVec2ih.ImVec2ih_Nil() end
    if ffi.istype('short',a1) then return ImVec2ih.ImVec2ih_short(a1,a2) end
    if ffi.istype('const ImVec2',a1) then return ImVec2ih.ImVec2ih_Vec2(a1) end
    print(ctype,a1,a2)
    error'ImVec2ih.__new could not find overloaded'
end
M.ImVec2ih = ffi.metatype("ImVec2ih",ImVec2ih)
------------------------------------------------------
function M.AcceptDragDropPayload(type,flags)
    flags = flags or 0
    return lib.igAcceptDragDropPayload(type,flags)
end
M.ActivateItem = lib.igActivateItem
M.AddContextHook = lib.igAddContextHook
M.AddSettingsHandler = lib.igAddSettingsHandler
M.AlignTextToFramePadding = lib.igAlignTextToFramePadding
M.ArrowButton = lib.igArrowButton
function M.ArrowButtonEx(str_id,dir,size_arg,flags)
    flags = flags or 0
    return lib.igArrowButtonEx(str_id,dir,size_arg,flags)
end
function M.Begin(name,p_open,flags)
    flags = flags or 0
    p_open = p_open or nil
    return lib.igBegin(name,p_open,flags)
end
function M.BeginChild_Str(str_id,size,border,flags)
    border = border or false
    flags = flags or 0
    size = size or ImVec2(0,0)
    return lib.igBeginChild_Str(str_id,size,border,flags)
end
function M.BeginChild_ID(id,size,border,flags)
    border = border or false
    flags = flags or 0
    size = size or ImVec2(0,0)
    return lib.igBeginChild_ID(id,size,border,flags)
end
function M.BeginChild(a1,a2,a3,a4) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.BeginChild_Str(a1,a2,a3,a4) end
    if ffi.istype('ImGuiID',a1) then return M.BeginChild_ID(a1,a2,a3,a4) end
    print(a1,a2,a3,a4)
    error'M.BeginChild could not find overloaded'
end
M.BeginChildEx = lib.igBeginChildEx
function M.BeginChildFrame(id,size,flags)
    flags = flags or 0
    return lib.igBeginChildFrame(id,size,flags)
end
function M.BeginColumns(str_id,count,flags)
    flags = flags or 0
    return lib.igBeginColumns(str_id,count,flags)
end
function M.BeginCombo(label,preview_value,flags)
    flags = flags or 0
    return lib.igBeginCombo(label,preview_value,flags)
end
M.BeginComboPopup = lib.igBeginComboPopup
M.BeginComboPreview = lib.igBeginComboPreview
function M.BeginDisabled(disabled)
    if disabled == nil then disabled = true end
    return lib.igBeginDisabled(disabled)
end
M.BeginDockableDragDropSource = lib.igBeginDockableDragDropSource
M.BeginDockableDragDropTarget = lib.igBeginDockableDragDropTarget
M.BeginDocked = lib.igBeginDocked
function M.BeginDragDropSource(flags)
    flags = flags or 0
    return lib.igBeginDragDropSource(flags)
end
M.BeginDragDropTarget = lib.igBeginDragDropTarget
M.BeginDragDropTargetCustom = lib.igBeginDragDropTargetCustom
M.BeginGroup = lib.igBeginGroup
function M.BeginListBox(label,size)
    size = size or ImVec2(0,0)
    return lib.igBeginListBox(label,size)
end
M.BeginMainMenuBar = lib.igBeginMainMenuBar
function M.BeginMenu(label,enabled)
    if enabled == nil then enabled = true end
    return lib.igBeginMenu(label,enabled)
end
M.BeginMenuBar = lib.igBeginMenuBar
function M.BeginMenuEx(label,icon,enabled)
    if enabled == nil then enabled = true end
    return lib.igBeginMenuEx(label,icon,enabled)
end
function M.BeginPopup(str_id,flags)
    flags = flags or 0
    return lib.igBeginPopup(str_id,flags)
end
function M.BeginPopupContextItem(str_id,popup_flags)
    popup_flags = popup_flags or 1
    str_id = str_id or nil
    return lib.igBeginPopupContextItem(str_id,popup_flags)
end
function M.BeginPopupContextVoid(str_id,popup_flags)
    popup_flags = popup_flags or 1
    str_id = str_id or nil
    return lib.igBeginPopupContextVoid(str_id,popup_flags)
end
function M.BeginPopupContextWindow(str_id,popup_flags)
    popup_flags = popup_flags or 1
    str_id = str_id or nil
    return lib.igBeginPopupContextWindow(str_id,popup_flags)
end
M.BeginPopupEx = lib.igBeginPopupEx
function M.BeginPopupModal(name,p_open,flags)
    flags = flags or 0
    p_open = p_open or nil
    return lib.igBeginPopupModal(name,p_open,flags)
end
function M.BeginTabBar(str_id,flags)
    flags = flags or 0
    return lib.igBeginTabBar(str_id,flags)
end
M.BeginTabBarEx = lib.igBeginTabBarEx
function M.BeginTabItem(label,p_open,flags)
    flags = flags or 0
    p_open = p_open or nil
    return lib.igBeginTabItem(label,p_open,flags)
end
function M.BeginTable(str_id,column,flags,outer_size,inner_width)
    flags = flags or 0
    inner_width = inner_width or 0.0
    outer_size = outer_size or ImVec2(0.0,0.0)
    return lib.igBeginTable(str_id,column,flags,outer_size,inner_width)
end
function M.BeginTableEx(name,id,columns_count,flags,outer_size,inner_width)
    flags = flags or 0
    inner_width = inner_width or 0.0
    outer_size = outer_size or ImVec2(0,0)
    return lib.igBeginTableEx(name,id,columns_count,flags,outer_size,inner_width)
end
M.BeginTooltip = lib.igBeginTooltip
M.BeginTooltipEx = lib.igBeginTooltipEx
M.BeginViewportSideBar = lib.igBeginViewportSideBar
M.BringWindowToDisplayBack = lib.igBringWindowToDisplayBack
M.BringWindowToDisplayBehind = lib.igBringWindowToDisplayBehind
M.BringWindowToDisplayFront = lib.igBringWindowToDisplayFront
M.BringWindowToFocusFront = lib.igBringWindowToFocusFront
M.Bullet = lib.igBullet
M.BulletText = lib.igBulletText
M.BulletTextV = lib.igBulletTextV
function M.Button(label,size)
    size = size or ImVec2(0,0)
    return lib.igButton(label,size)
end
function M.ButtonBehavior(bb,id,out_hovered,out_held,flags)
    flags = flags or 0
    return lib.igButtonBehavior(bb,id,out_hovered,out_held,flags)
end
function M.ButtonEx(label,size_arg,flags)
    flags = flags or 0
    size_arg = size_arg or ImVec2(0,0)
    return lib.igButtonEx(label,size_arg,flags)
end
function M.CalcItemSize(size,default_w,default_h)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igCalcItemSize(nonUDT_out,size,default_w,default_h)
    return nonUDT_out
end
M.CalcItemWidth = lib.igCalcItemWidth
M.CalcRoundingFlagsForRectInRect = lib.igCalcRoundingFlagsForRectInRect
function M.CalcTextSize(text,text_end,hide_text_after_double_hash,wrap_width)
    hide_text_after_double_hash = hide_text_after_double_hash or false
    text_end = text_end or nil
    wrap_width = wrap_width or -1.0
    local nonUDT_out = ffi.new("ImVec2")
    lib.igCalcTextSize(nonUDT_out,text,text_end,hide_text_after_double_hash,wrap_width)
    return nonUDT_out
end
M.CalcTypematicRepeatAmount = lib.igCalcTypematicRepeatAmount
function M.CalcWindowNextAutoFitSize(window)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igCalcWindowNextAutoFitSize(nonUDT_out,window)
    return nonUDT_out
end
M.CalcWrapWidthForPos = lib.igCalcWrapWidthForPos
M.CallContextHooks = lib.igCallContextHooks
M.Checkbox = lib.igCheckbox
M.CheckboxFlags_IntPtr = lib.igCheckboxFlags_IntPtr
M.CheckboxFlags_UintPtr = lib.igCheckboxFlags_UintPtr
M.CheckboxFlags_S64Ptr = lib.igCheckboxFlags_S64Ptr
M.CheckboxFlags_U64Ptr = lib.igCheckboxFlags_U64Ptr
function M.CheckboxFlags(a1,a2,a3) -- generic version
    if (ffi.istype('int*',a2) or ffi.istype('int[]',a2)) then return M.CheckboxFlags_IntPtr(a1,a2,a3) end
    if (ffi.istype('unsigned int*',a2) or ffi.istype('unsigned int',a2) or ffi.istype('unsigned int[]',a2)) then return M.CheckboxFlags_UintPtr(a1,a2,a3) end
    if (ffi.istype('ImS64*',a2) or ffi.istype('ImS64',a2) or ffi.istype('ImS64[]',a2)) then return M.CheckboxFlags_S64Ptr(a1,a2,a3) end
    if (ffi.istype('ImU64*',a2) or ffi.istype('ImU64',a2) or ffi.istype('ImU64[]',a2)) then return M.CheckboxFlags_U64Ptr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.CheckboxFlags could not find overloaded'
end
M.ClearActiveID = lib.igClearActiveID
M.ClearDragDrop = lib.igClearDragDrop
M.ClearIniSettings = lib.igClearIniSettings
M.CloseButton = lib.igCloseButton
M.CloseCurrentPopup = lib.igCloseCurrentPopup
M.ClosePopupToLevel = lib.igClosePopupToLevel
M.ClosePopupsExceptModals = lib.igClosePopupsExceptModals
M.ClosePopupsOverWindow = lib.igClosePopupsOverWindow
M.CollapseButton = lib.igCollapseButton
function M.CollapsingHeader_TreeNodeFlags(label,flags)
    flags = flags or 0
    return lib.igCollapsingHeader_TreeNodeFlags(label,flags)
end
function M.CollapsingHeader_BoolPtr(label,p_visible,flags)
    flags = flags or 0
    return lib.igCollapsingHeader_BoolPtr(label,p_visible,flags)
end
function M.CollapsingHeader(a1,a2,a3) -- generic version
    if ((ffi.istype('ImGuiTreeNodeFlags',a2) or type(a2)=='number') or type(a2)=='nil') then return M.CollapsingHeader_TreeNodeFlags(a1,a2) end
    if (ffi.istype('bool*',a2) or ffi.istype('bool',a2) or ffi.istype('bool[]',a2)) then return M.CollapsingHeader_BoolPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.CollapsingHeader could not find overloaded'
end
function M.ColorButton(desc_id,col,flags,size)
    flags = flags or 0
    size = size or ImVec2(0,0)
    return lib.igColorButton(desc_id,col,flags,size)
end
M.ColorConvertFloat4ToU32 = lib.igColorConvertFloat4ToU32
M.ColorConvertHSVtoRGB = lib.igColorConvertHSVtoRGB
M.ColorConvertRGBtoHSV = lib.igColorConvertRGBtoHSV
function M.ColorConvertU32ToFloat4(_in)
    local nonUDT_out = ffi.new("ImVec4")
    lib.igColorConvertU32ToFloat4(nonUDT_out,_in)
    return nonUDT_out
end
function M.ColorEdit3(label,col,flags)
    flags = flags or 0
    return lib.igColorEdit3(label,col,flags)
end
function M.ColorEdit4(label,col,flags)
    flags = flags or 0
    return lib.igColorEdit4(label,col,flags)
end
M.ColorEditOptionsPopup = lib.igColorEditOptionsPopup
function M.ColorPicker3(label,col,flags)
    flags = flags or 0
    return lib.igColorPicker3(label,col,flags)
end
function M.ColorPicker4(label,col,flags,ref_col)
    flags = flags or 0
    ref_col = ref_col or nil
    return lib.igColorPicker4(label,col,flags,ref_col)
end
M.ColorPickerOptionsPopup = lib.igColorPickerOptionsPopup
M.ColorTooltip = lib.igColorTooltip
function M.Columns(count,id,border)
    if border == nil then border = true end
    count = count or 1
    id = id or nil
    return lib.igColumns(count,id,border)
end
function M.Combo_Str_arr(label,current_item,items,items_count,popup_max_height_in_items)
    popup_max_height_in_items = popup_max_height_in_items or -1
    return lib.igCombo_Str_arr(label,current_item,items,items_count,popup_max_height_in_items)
end
function M.Combo_Str(label,current_item,items_separated_by_zeros,popup_max_height_in_items)
    popup_max_height_in_items = popup_max_height_in_items or -1
    return lib.igCombo_Str(label,current_item,items_separated_by_zeros,popup_max_height_in_items)
end
function M.Combo_FnBoolPtr(label,current_item,items_getter,data,items_count,popup_max_height_in_items)
    popup_max_height_in_items = popup_max_height_in_items or -1
    return lib.igCombo_FnBoolPtr(label,current_item,items_getter,data,items_count,popup_max_height_in_items)
end
function M.Combo(a1,a2,a3,a4,a5,a6) -- generic version
    if (ffi.istype('const char* const[]',a3) or ffi.istype('const char const[]',a3) or ffi.istype('const char const[][]',a3)) then return M.Combo_Str_arr(a1,a2,a3,a4,a5) end
    if (ffi.istype('const char*',a3) or ffi.istype('char[]',a3) or type(a3)=='string') then return M.Combo_Str(a1,a2,a3,a4) end
    if ffi.istype('bool(*)(void* data,int idx,const char** out_text)',a3) then return M.Combo_FnBoolPtr(a1,a2,a3,a4,a5,a6) end
    print(a1,a2,a3,a4,a5,a6)
    error'M.Combo could not find overloaded'
end
function M.CreateContext(shared_font_atlas)
    shared_font_atlas = shared_font_atlas or nil
    return lib.igCreateContext(shared_font_atlas)
end
M.CreateNewWindowSettings = lib.igCreateNewWindowSettings
M.DataTypeApplyFromText = lib.igDataTypeApplyFromText
M.DataTypeApplyOp = lib.igDataTypeApplyOp
M.DataTypeClamp = lib.igDataTypeClamp
M.DataTypeCompare = lib.igDataTypeCompare
M.DataTypeFormatString = lib.igDataTypeFormatString
M.DataTypeGetInfo = lib.igDataTypeGetInfo
M.DebugCheckVersionAndDataLayout = lib.igDebugCheckVersionAndDataLayout
function M.DebugDrawItemRect(col)
    col = col or 4278190335
    return lib.igDebugDrawItemRect(col)
end
M.DebugHookIdInfo = lib.igDebugHookIdInfo
M.DebugLog = lib.igDebugLog
M.DebugLogV = lib.igDebugLogV
M.DebugNodeColumns = lib.igDebugNodeColumns
M.DebugNodeDockNode = lib.igDebugNodeDockNode
M.DebugNodeDrawCmdShowMeshAndBoundingBox = lib.igDebugNodeDrawCmdShowMeshAndBoundingBox
M.DebugNodeDrawList = lib.igDebugNodeDrawList
M.DebugNodeFont = lib.igDebugNodeFont
M.DebugNodeFontGlyph = lib.igDebugNodeFontGlyph
M.DebugNodeInputTextState = lib.igDebugNodeInputTextState
M.DebugNodeStorage = lib.igDebugNodeStorage
M.DebugNodeTabBar = lib.igDebugNodeTabBar
M.DebugNodeTable = lib.igDebugNodeTable
M.DebugNodeTableSettings = lib.igDebugNodeTableSettings
M.DebugNodeViewport = lib.igDebugNodeViewport
M.DebugNodeWindow = lib.igDebugNodeWindow
M.DebugNodeWindowSettings = lib.igDebugNodeWindowSettings
M.DebugNodeWindowsList = lib.igDebugNodeWindowsList
M.DebugNodeWindowsListByBeginStackParent = lib.igDebugNodeWindowsListByBeginStackParent
M.DebugRenderViewportThumbnail = lib.igDebugRenderViewportThumbnail
M.DebugStartItemPicker = lib.igDebugStartItemPicker
M.DebugTextEncoding = lib.igDebugTextEncoding
function M.DestroyContext(ctx)
    ctx = ctx or nil
    return lib.igDestroyContext(ctx)
end
M.DestroyPlatformWindow = lib.igDestroyPlatformWindow
M.DestroyPlatformWindows = lib.igDestroyPlatformWindows
function M.DockBuilderAddNode(node_id,flags)
    flags = flags or 0
    node_id = node_id or 0
    return lib.igDockBuilderAddNode(node_id,flags)
end
M.DockBuilderCopyDockSpace = lib.igDockBuilderCopyDockSpace
M.DockBuilderCopyNode = lib.igDockBuilderCopyNode
M.DockBuilderCopyWindowSettings = lib.igDockBuilderCopyWindowSettings
M.DockBuilderDockWindow = lib.igDockBuilderDockWindow
M.DockBuilderFinish = lib.igDockBuilderFinish
M.DockBuilderGetCentralNode = lib.igDockBuilderGetCentralNode
M.DockBuilderGetNode = lib.igDockBuilderGetNode
M.DockBuilderRemoveNode = lib.igDockBuilderRemoveNode
M.DockBuilderRemoveNodeChildNodes = lib.igDockBuilderRemoveNodeChildNodes
function M.DockBuilderRemoveNodeDockedWindows(node_id,clear_settings_refs)
    if clear_settings_refs == nil then clear_settings_refs = true end
    return lib.igDockBuilderRemoveNodeDockedWindows(node_id,clear_settings_refs)
end
M.DockBuilderSetNodePos = lib.igDockBuilderSetNodePos
M.DockBuilderSetNodeSize = lib.igDockBuilderSetNodeSize
M.DockBuilderSplitNode = lib.igDockBuilderSplitNode
M.DockContextCalcDropPosForDocking = lib.igDockContextCalcDropPosForDocking
M.DockContextClearNodes = lib.igDockContextClearNodes
M.DockContextEndFrame = lib.igDockContextEndFrame
M.DockContextGenNodeID = lib.igDockContextGenNodeID
M.DockContextInitialize = lib.igDockContextInitialize
M.DockContextNewFrameUpdateDocking = lib.igDockContextNewFrameUpdateDocking
M.DockContextNewFrameUpdateUndocking = lib.igDockContextNewFrameUpdateUndocking
M.DockContextQueueDock = lib.igDockContextQueueDock
M.DockContextQueueUndockNode = lib.igDockContextQueueUndockNode
M.DockContextQueueUndockWindow = lib.igDockContextQueueUndockWindow
M.DockContextRebuildNodes = lib.igDockContextRebuildNodes
M.DockContextShutdown = lib.igDockContextShutdown
M.DockNodeBeginAmendTabBar = lib.igDockNodeBeginAmendTabBar
M.DockNodeEndAmendTabBar = lib.igDockNodeEndAmendTabBar
M.DockNodeGetDepth = lib.igDockNodeGetDepth
M.DockNodeGetRootNode = lib.igDockNodeGetRootNode
M.DockNodeGetWindowMenuButtonId = lib.igDockNodeGetWindowMenuButtonId
M.DockNodeIsInHierarchyOf = lib.igDockNodeIsInHierarchyOf
function M.DockSpace(id,size,flags,window_class)
    flags = flags or 0
    size = size or ImVec2(0,0)
    window_class = window_class or nil
    return lib.igDockSpace(id,size,flags,window_class)
end
function M.DockSpaceOverViewport(viewport,flags,window_class)
    flags = flags or 0
    viewport = viewport or nil
    window_class = window_class or nil
    return lib.igDockSpaceOverViewport(viewport,flags,window_class)
end
M.DragBehavior = lib.igDragBehavior
function M.DragFloat(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    v_max = v_max or 0.0
    v_min = v_min or 0.0
    v_speed = v_speed or 1.0
    return lib.igDragFloat(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragFloat2(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    v_max = v_max or 0.0
    v_min = v_min or 0.0
    v_speed = v_speed or 1.0
    return lib.igDragFloat2(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragFloat3(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    v_max = v_max or 0.0
    v_min = v_min or 0.0
    v_speed = v_speed or 1.0
    return lib.igDragFloat3(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragFloat4(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    v_max = v_max or 0.0
    v_min = v_min or 0.0
    v_speed = v_speed or 1.0
    return lib.igDragFloat4(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragFloatRange2(label,v_current_min,v_current_max,v_speed,v_min,v_max,format,format_max,flags)
    flags = flags or 0
    format = format or "%.3f"
    format_max = format_max or nil
    v_max = v_max or 0.0
    v_min = v_min or 0.0
    v_speed = v_speed or 1.0
    return lib.igDragFloatRange2(label,v_current_min,v_current_max,v_speed,v_min,v_max,format,format_max,flags)
end
function M.DragInt(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    v_max = v_max or 0
    v_min = v_min or 0
    v_speed = v_speed or 1.0
    return lib.igDragInt(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragInt2(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    v_max = v_max or 0
    v_min = v_min or 0
    v_speed = v_speed or 1.0
    return lib.igDragInt2(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragInt3(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    v_max = v_max or 0
    v_min = v_min or 0
    v_speed = v_speed or 1.0
    return lib.igDragInt3(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragInt4(label,v,v_speed,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    v_max = v_max or 0
    v_min = v_min or 0
    v_speed = v_speed or 1.0
    return lib.igDragInt4(label,v,v_speed,v_min,v_max,format,flags)
end
function M.DragIntRange2(label,v_current_min,v_current_max,v_speed,v_min,v_max,format,format_max,flags)
    flags = flags or 0
    format = format or "%d"
    format_max = format_max or nil
    v_max = v_max or 0
    v_min = v_min or 0
    v_speed = v_speed or 1.0
    return lib.igDragIntRange2(label,v_current_min,v_current_max,v_speed,v_min,v_max,format,format_max,flags)
end
function M.DragScalar(label,data_type,p_data,v_speed,p_min,p_max,format,flags)
    flags = flags or 0
    format = format or nil
    p_max = p_max or nil
    p_min = p_min or nil
    v_speed = v_speed or 1.0
    return lib.igDragScalar(label,data_type,p_data,v_speed,p_min,p_max,format,flags)
end
function M.DragScalarN(label,data_type,p_data,components,v_speed,p_min,p_max,format,flags)
    flags = flags or 0
    format = format or nil
    p_max = p_max or nil
    p_min = p_min or nil
    v_speed = v_speed or 1.0
    return lib.igDragScalarN(label,data_type,p_data,components,v_speed,p_min,p_max,format,flags)
end
M.Dummy = lib.igDummy
M.End = lib.igEnd
M.EndChild = lib.igEndChild
M.EndChildFrame = lib.igEndChildFrame
M.EndColumns = lib.igEndColumns
M.EndCombo = lib.igEndCombo
M.EndComboPreview = lib.igEndComboPreview
M.EndDisabled = lib.igEndDisabled
M.EndDragDropSource = lib.igEndDragDropSource
M.EndDragDropTarget = lib.igEndDragDropTarget
M.EndFrame = lib.igEndFrame
M.EndGroup = lib.igEndGroup
M.EndListBox = lib.igEndListBox
M.EndMainMenuBar = lib.igEndMainMenuBar
M.EndMenu = lib.igEndMenu
M.EndMenuBar = lib.igEndMenuBar
M.EndPopup = lib.igEndPopup
M.EndTabBar = lib.igEndTabBar
M.EndTabItem = lib.igEndTabItem
M.EndTable = lib.igEndTable
M.EndTooltip = lib.igEndTooltip
function M.ErrorCheckEndFrameRecover(log_callback,user_data)
    user_data = user_data or nil
    return lib.igErrorCheckEndFrameRecover(log_callback,user_data)
end
function M.ErrorCheckEndWindowRecover(log_callback,user_data)
    user_data = user_data or nil
    return lib.igErrorCheckEndWindowRecover(log_callback,user_data)
end
function M.FindBestWindowPosForPopup(window)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igFindBestWindowPosForPopup(nonUDT_out,window)
    return nonUDT_out
end
function M.FindBestWindowPosForPopupEx(ref_pos,size,last_dir,r_outer,r_avoid,policy)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igFindBestWindowPosForPopupEx(nonUDT_out,ref_pos,size,last_dir,r_outer,r_avoid,policy)
    return nonUDT_out
end
M.FindBottomMostVisibleWindowWithinBeginStack = lib.igFindBottomMostVisibleWindowWithinBeginStack
M.FindHoveredViewportFromPlatformWindowStack = lib.igFindHoveredViewportFromPlatformWindowStack
M.FindOrCreateColumns = lib.igFindOrCreateColumns
M.FindOrCreateWindowSettings = lib.igFindOrCreateWindowSettings
function M.FindRenderedTextEnd(text,text_end)
    text_end = text_end or nil
    return lib.igFindRenderedTextEnd(text,text_end)
end
M.FindSettingsHandler = lib.igFindSettingsHandler
M.FindViewportByID = lib.igFindViewportByID
M.FindViewportByPlatformHandle = lib.igFindViewportByPlatformHandle
M.FindWindowByID = lib.igFindWindowByID
M.FindWindowByName = lib.igFindWindowByName
M.FindWindowDisplayIndex = lib.igFindWindowDisplayIndex
M.FindWindowSettings = lib.igFindWindowSettings
M.FocusTopMostWindowUnderOne = lib.igFocusTopMostWindowUnderOne
M.FocusWindow = lib.igFocusWindow
M.GcAwakeTransientWindowBuffers = lib.igGcAwakeTransientWindowBuffers
M.GcCompactTransientMiscBuffers = lib.igGcCompactTransientMiscBuffers
M.GcCompactTransientWindowBuffers = lib.igGcCompactTransientWindowBuffers
M.GetActiveID = lib.igGetActiveID
M.GetAllocatorFunctions = lib.igGetAllocatorFunctions
M.GetBackgroundDrawList_Nil = lib.igGetBackgroundDrawList_Nil
M.GetBackgroundDrawList_ViewportPtr = lib.igGetBackgroundDrawList_ViewportPtr
function M.GetBackgroundDrawList(a1) -- generic version
    if a1==nil then return M.GetBackgroundDrawList_Nil() end
    if (ffi.istype('ImGuiViewport*',a1) or ffi.istype('ImGuiViewport',a1) or ffi.istype('ImGuiViewport[]',a1)) then return M.GetBackgroundDrawList_ViewportPtr(a1) end
    print(a1)
    error'M.GetBackgroundDrawList could not find overloaded'
end
M.GetClipboardText = lib.igGetClipboardText
function M.GetColorU32_Col(idx,alpha_mul)
    alpha_mul = alpha_mul or 1.0
    return lib.igGetColorU32_Col(idx,alpha_mul)
end
M.GetColorU32_Vec4 = lib.igGetColorU32_Vec4
M.GetColorU32_U32 = lib.igGetColorU32_U32
function M.GetColorU32(a1,a2) -- generic version
    if (ffi.istype('ImGuiCol',a1) or type(a1)=='number') then return M.GetColorU32_Col(a1,a2) end
    if ffi.istype('const ImVec4',a1) then return M.GetColorU32_Vec4(a1) end
    if (ffi.istype('ImU32',a1) or type(a1)=='number') then return M.GetColorU32_U32(a1) end
    print(a1,a2)
    error'M.GetColorU32 could not find overloaded'
end
M.GetColumnIndex = lib.igGetColumnIndex
M.GetColumnNormFromOffset = lib.igGetColumnNormFromOffset
function M.GetColumnOffset(column_index)
    column_index = column_index or -1
    return lib.igGetColumnOffset(column_index)
end
M.GetColumnOffsetFromNorm = lib.igGetColumnOffsetFromNorm
function M.GetColumnWidth(column_index)
    column_index = column_index or -1
    return lib.igGetColumnWidth(column_index)
end
M.GetColumnsCount = lib.igGetColumnsCount
M.GetColumnsID = lib.igGetColumnsID
function M.GetContentRegionAvail()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetContentRegionAvail(nonUDT_out)
    return nonUDT_out
end
function M.GetContentRegionMax()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetContentRegionMax(nonUDT_out)
    return nonUDT_out
end
function M.GetContentRegionMaxAbs()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetContentRegionMaxAbs(nonUDT_out)
    return nonUDT_out
end
M.GetCurrentContext = lib.igGetCurrentContext
M.GetCurrentTable = lib.igGetCurrentTable
M.GetCurrentWindow = lib.igGetCurrentWindow
M.GetCurrentWindowRead = lib.igGetCurrentWindowRead
function M.GetCursorPos()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetCursorPos(nonUDT_out)
    return nonUDT_out
end
M.GetCursorPosX = lib.igGetCursorPosX
M.GetCursorPosY = lib.igGetCursorPosY
function M.GetCursorScreenPos()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetCursorScreenPos(nonUDT_out)
    return nonUDT_out
end
function M.GetCursorStartPos()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetCursorStartPos(nonUDT_out)
    return nonUDT_out
end
M.GetDefaultFont = lib.igGetDefaultFont
M.GetDragDropPayload = lib.igGetDragDropPayload
M.GetDrawData = lib.igGetDrawData
M.GetDrawListSharedData = lib.igGetDrawListSharedData
M.GetFocusID = lib.igGetFocusID
M.GetFocusScope = lib.igGetFocusScope
M.GetFocusedFocusScope = lib.igGetFocusedFocusScope
M.GetFont = lib.igGetFont
M.GetFontSize = lib.igGetFontSize
function M.GetFontTexUvWhitePixel()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetFontTexUvWhitePixel(nonUDT_out)
    return nonUDT_out
end
M.GetForegroundDrawList_Nil = lib.igGetForegroundDrawList_Nil
M.GetForegroundDrawList_ViewportPtr = lib.igGetForegroundDrawList_ViewportPtr
M.GetForegroundDrawList_WindowPtr = lib.igGetForegroundDrawList_WindowPtr
function M.GetForegroundDrawList(a1) -- generic version
    if a1==nil then return M.GetForegroundDrawList_Nil() end
    if (ffi.istype('ImGuiViewport*',a1) or ffi.istype('ImGuiViewport',a1) or ffi.istype('ImGuiViewport[]',a1)) then return M.GetForegroundDrawList_ViewportPtr(a1) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.GetForegroundDrawList_WindowPtr(a1) end
    print(a1)
    error'M.GetForegroundDrawList could not find overloaded'
end
M.GetFrameCount = lib.igGetFrameCount
M.GetFrameHeight = lib.igGetFrameHeight
M.GetFrameHeightWithSpacing = lib.igGetFrameHeightWithSpacing
M.GetHoveredID = lib.igGetHoveredID
M.GetID_Str = lib.igGetID_Str
M.GetID_StrStr = lib.igGetID_StrStr
M.GetID_Ptr = lib.igGetID_Ptr
function M.GetID(a1,a2) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and a2==nil then return M.GetID_Str(a1) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and (ffi.istype('const char*',a2) or ffi.istype('char[]',a2) or type(a2)=='string') then return M.GetID_StrStr(a1,a2) end
    if ffi.istype('const void*',a1) then return M.GetID_Ptr(a1) end
    print(a1,a2)
    error'M.GetID could not find overloaded'
end
M.GetIDWithSeed = lib.igGetIDWithSeed
M.GetIO = lib.igGetIO
M.GetInputTextState = lib.igGetInputTextState
M.GetItemFlags = lib.igGetItemFlags
M.GetItemID = lib.igGetItemID
function M.GetItemRectMax()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetItemRectMax(nonUDT_out)
    return nonUDT_out
end
function M.GetItemRectMin()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetItemRectMin(nonUDT_out)
    return nonUDT_out
end
function M.GetItemRectSize()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetItemRectSize(nonUDT_out)
    return nonUDT_out
end
M.GetItemStatusFlags = lib.igGetItemStatusFlags
M.GetKeyData = lib.igGetKeyData
M.GetKeyIndex = lib.igGetKeyIndex
M.GetKeyName = lib.igGetKeyName
M.GetKeyPressedAmount = lib.igGetKeyPressedAmount
M.GetMainViewport = lib.igGetMainViewport
M.GetMergedModFlags = lib.igGetMergedModFlags
M.GetMouseClickedCount = lib.igGetMouseClickedCount
M.GetMouseCursor = lib.igGetMouseCursor
function M.GetMouseDragDelta(button,lock_threshold)
    button = button or 0
    lock_threshold = lock_threshold or -1.0
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetMouseDragDelta(nonUDT_out,button,lock_threshold)
    return nonUDT_out
end
function M.GetMousePos()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetMousePos(nonUDT_out)
    return nonUDT_out
end
function M.GetMousePosOnOpeningCurrentPopup()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetMousePosOnOpeningCurrentPopup(nonUDT_out)
    return nonUDT_out
end
M.GetNavInputAmount = lib.igGetNavInputAmount
function M.GetNavInputAmount2d(dir_sources,mode,slow_factor,fast_factor)
    fast_factor = fast_factor or 0.0
    slow_factor = slow_factor or 0.0
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetNavInputAmount2d(nonUDT_out,dir_sources,mode,slow_factor,fast_factor)
    return nonUDT_out
end
M.GetNavInputName = lib.igGetNavInputName
M.GetPlatformIO = lib.igGetPlatformIO
function M.GetPopupAllowedExtentRect(window)
    local nonUDT_out = ffi.new("ImRect")
    lib.igGetPopupAllowedExtentRect(nonUDT_out,window)
    return nonUDT_out
end
M.GetScrollMaxX = lib.igGetScrollMaxX
M.GetScrollMaxY = lib.igGetScrollMaxY
M.GetScrollX = lib.igGetScrollX
M.GetScrollY = lib.igGetScrollY
M.GetStateStorage = lib.igGetStateStorage
M.GetStyle = lib.igGetStyle
M.GetStyleColorName = lib.igGetStyleColorName
M.GetStyleColorVec4 = lib.igGetStyleColorVec4
M.GetTextLineHeight = lib.igGetTextLineHeight
M.GetTextLineHeightWithSpacing = lib.igGetTextLineHeightWithSpacing
M.GetTime = lib.igGetTime
M.GetTopMostAndVisiblePopupModal = lib.igGetTopMostAndVisiblePopupModal
M.GetTopMostPopupModal = lib.igGetTopMostPopupModal
M.GetTreeNodeToLabelSpacing = lib.igGetTreeNodeToLabelSpacing
M.GetVersion = lib.igGetVersion
M.GetViewportPlatformMonitor = lib.igGetViewportPlatformMonitor
M.GetWindowAlwaysWantOwnTabBar = lib.igGetWindowAlwaysWantOwnTabBar
function M.GetWindowContentRegionMax()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetWindowContentRegionMax(nonUDT_out)
    return nonUDT_out
end
function M.GetWindowContentRegionMin()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetWindowContentRegionMin(nonUDT_out)
    return nonUDT_out
end
M.GetWindowDockID = lib.igGetWindowDockID
M.GetWindowDockNode = lib.igGetWindowDockNode
M.GetWindowDpiScale = lib.igGetWindowDpiScale
M.GetWindowDrawList = lib.igGetWindowDrawList
M.GetWindowHeight = lib.igGetWindowHeight
function M.GetWindowPos()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetWindowPos(nonUDT_out)
    return nonUDT_out
end
M.GetWindowResizeBorderID = lib.igGetWindowResizeBorderID
M.GetWindowResizeCornerID = lib.igGetWindowResizeCornerID
M.GetWindowScrollbarID = lib.igGetWindowScrollbarID
function M.GetWindowScrollbarRect(window,axis)
    local nonUDT_out = ffi.new("ImRect")
    lib.igGetWindowScrollbarRect(nonUDT_out,window,axis)
    return nonUDT_out
end
function M.GetWindowSize()
    local nonUDT_out = ffi.new("ImVec2")
    lib.igGetWindowSize(nonUDT_out)
    return nonUDT_out
end
M.GetWindowViewport = lib.igGetWindowViewport
M.GetWindowWidth = lib.igGetWindowWidth
M.ImAbs_Int = lib.igImAbs_Int
M.ImAbs_Float = lib.igImAbs_Float
M.ImAbs_double = lib.igImAbs_double
function M.ImAbs(a1) -- generic version
    if (ffi.istype('int',a1) or type(a1)=='number') then return M.ImAbs_Int(a1) end
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImAbs_Float(a1) end
    if (ffi.istype('double',a1) or type(a1)=='number') then return M.ImAbs_double(a1) end
    print(a1)
    error'M.ImAbs could not find overloaded'
end
M.ImAlphaBlendColors = lib.igImAlphaBlendColors
function M.ImBezierCubicCalc(p1,p2,p3,p4,t)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImBezierCubicCalc(nonUDT_out,p1,p2,p3,p4,t)
    return nonUDT_out
end
function M.ImBezierCubicClosestPoint(p1,p2,p3,p4,p,num_segments)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImBezierCubicClosestPoint(nonUDT_out,p1,p2,p3,p4,p,num_segments)
    return nonUDT_out
end
function M.ImBezierCubicClosestPointCasteljau(p1,p2,p3,p4,p,tess_tol)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImBezierCubicClosestPointCasteljau(nonUDT_out,p1,p2,p3,p4,p,tess_tol)
    return nonUDT_out
end
function M.ImBezierQuadraticCalc(p1,p2,p3,t)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImBezierQuadraticCalc(nonUDT_out,p1,p2,p3,t)
    return nonUDT_out
end
M.ImBitArrayClearBit = lib.igImBitArrayClearBit
M.ImBitArraySetBit = lib.igImBitArraySetBit
M.ImBitArraySetBitRange = lib.igImBitArraySetBitRange
M.ImBitArrayTestBit = lib.igImBitArrayTestBit
M.ImCharIsBlankA = lib.igImCharIsBlankA
M.ImCharIsBlankW = lib.igImCharIsBlankW
function M.ImClamp(v,mn,mx)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImClamp(nonUDT_out,v,mn,mx)
    return nonUDT_out
end
M.ImDot = lib.igImDot
M.ImFileClose = lib.igImFileClose
M.ImFileGetSize = lib.igImFileGetSize
function M.ImFileLoadToMemory(filename,mode,out_file_size,padding_bytes)
    out_file_size = out_file_size or nil
    padding_bytes = padding_bytes or 0
    return lib.igImFileLoadToMemory(filename,mode,out_file_size,padding_bytes)
end
M.ImFileOpen = lib.igImFileOpen
M.ImFileRead = lib.igImFileRead
M.ImFileWrite = lib.igImFileWrite
M.ImFloor_Float = lib.igImFloor_Float
function M.ImFloor_Vec2(v)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImFloor_Vec2(nonUDT_out,v)
    return nonUDT_out
end
function M.ImFloor(a1,a2) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImFloor_Float(a1) end
    if (ffi.istype('ImVec2*',a1) or ffi.istype('ImVec2',a1) or ffi.istype('ImVec2[]',a1)) then return M.ImFloor_Vec2(a2) end
    print(a1,a2)
    error'M.ImFloor could not find overloaded'
end
M.ImFloorSigned_Float = lib.igImFloorSigned_Float
function M.ImFloorSigned_Vec2(v)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImFloorSigned_Vec2(nonUDT_out,v)
    return nonUDT_out
end
function M.ImFloorSigned(a1,a2) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImFloorSigned_Float(a1) end
    if (ffi.istype('ImVec2*',a1) or ffi.istype('ImVec2',a1) or ffi.istype('ImVec2[]',a1)) then return M.ImFloorSigned_Vec2(a2) end
    print(a1,a2)
    error'M.ImFloorSigned could not find overloaded'
end
M.ImFontAtlasBuildFinish = lib.igImFontAtlasBuildFinish
M.ImFontAtlasBuildInit = lib.igImFontAtlasBuildInit
M.ImFontAtlasBuildMultiplyCalcLookupTable = lib.igImFontAtlasBuildMultiplyCalcLookupTable
M.ImFontAtlasBuildMultiplyRectAlpha8 = lib.igImFontAtlasBuildMultiplyRectAlpha8
M.ImFontAtlasBuildPackCustomRects = lib.igImFontAtlasBuildPackCustomRects
M.ImFontAtlasBuildRender32bppRectFromString = lib.igImFontAtlasBuildRender32bppRectFromString
M.ImFontAtlasBuildRender8bppRectFromString = lib.igImFontAtlasBuildRender8bppRectFromString
M.ImFontAtlasBuildSetupFont = lib.igImFontAtlasBuildSetupFont
M.ImFontAtlasGetBuilderForStbTruetype = lib.igImFontAtlasGetBuilderForStbTruetype
M.ImFormatString = lib.igImFormatString
M.ImFormatStringToTempBuffer = lib.igImFormatStringToTempBuffer
M.ImFormatStringToTempBufferV = lib.igImFormatStringToTempBufferV
M.ImFormatStringV = lib.igImFormatStringV
M.ImGetDirQuadrantFromDelta = lib.igImGetDirQuadrantFromDelta
function M.ImHashData(data,data_size,seed)
    seed = seed or 0
    return lib.igImHashData(data,data_size,seed)
end
function M.ImHashStr(data,data_size,seed)
    data_size = data_size or 0
    seed = seed or 0
    return lib.igImHashStr(data,data_size,seed)
end
M.ImInvLength = lib.igImInvLength
M.ImIsFloatAboveGuaranteedIntegerPrecision = lib.igImIsFloatAboveGuaranteedIntegerPrecision
M.ImIsPowerOfTwo_Int = lib.igImIsPowerOfTwo_Int
M.ImIsPowerOfTwo_U64 = lib.igImIsPowerOfTwo_U64
function M.ImIsPowerOfTwo(a1) -- generic version
    if (ffi.istype('int',a1) or type(a1)=='number') then return M.ImIsPowerOfTwo_Int(a1) end
    if ffi.istype('ImU64',a1) then return M.ImIsPowerOfTwo_U64(a1) end
    print(a1)
    error'M.ImIsPowerOfTwo could not find overloaded'
end
M.ImLengthSqr_Vec2 = lib.igImLengthSqr_Vec2
M.ImLengthSqr_Vec4 = lib.igImLengthSqr_Vec4
function M.ImLengthSqr(a1) -- generic version
    if ffi.istype('const ImVec2',a1) then return M.ImLengthSqr_Vec2(a1) end
    if ffi.istype('const ImVec4',a1) then return M.ImLengthSqr_Vec4(a1) end
    print(a1)
    error'M.ImLengthSqr could not find overloaded'
end
function M.ImLerp_Vec2Float(a,b,t)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImLerp_Vec2Float(nonUDT_out,a,b,t)
    return nonUDT_out
end
function M.ImLerp_Vec2Vec2(a,b,t)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImLerp_Vec2Vec2(nonUDT_out,a,b,t)
    return nonUDT_out
end
function M.ImLerp_Vec4(a,b,t)
    local nonUDT_out = ffi.new("ImVec4")
    lib.igImLerp_Vec4(nonUDT_out,a,b,t)
    return nonUDT_out
end
function M.ImLerp(a2,a3,a4) -- generic version
    if (ffi.istype('ImVec2*',a1) or ffi.istype('ImVec2',a1) or ffi.istype('ImVec2[]',a1)) and (ffi.istype('float',a4) or type(a4)=='number') then return M.ImLerp_Vec2Float(a2,a3,a4) end
    if (ffi.istype('ImVec2*',a1) or ffi.istype('ImVec2',a1) or ffi.istype('ImVec2[]',a1)) and ffi.istype('const ImVec2',a4) then return M.ImLerp_Vec2Vec2(a2,a3,a4) end
    if (ffi.istype('ImVec4*',a1) or ffi.istype('ImVec4',a1) or ffi.istype('ImVec4[]',a1)) then return M.ImLerp_Vec4(a2,a3,a4) end
    print(a2,a3,a4)
    error'M.ImLerp could not find overloaded'
end
function M.ImLineClosestPoint(a,b,p)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImLineClosestPoint(nonUDT_out,a,b,p)
    return nonUDT_out
end
M.ImLinearSweep = lib.igImLinearSweep
M.ImLog_Float = lib.igImLog_Float
M.ImLog_double = lib.igImLog_double
function M.ImLog(a1) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImLog_Float(a1) end
    if (ffi.istype('double',a1) or type(a1)=='number') then return M.ImLog_double(a1) end
    print(a1)
    error'M.ImLog could not find overloaded'
end
function M.ImMax(lhs,rhs)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImMax(nonUDT_out,lhs,rhs)
    return nonUDT_out
end
function M.ImMin(lhs,rhs)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImMin(nonUDT_out,lhs,rhs)
    return nonUDT_out
end
M.ImModPositive = lib.igImModPositive
function M.ImMul(lhs,rhs)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImMul(nonUDT_out,lhs,rhs)
    return nonUDT_out
end
M.ImParseFormatFindEnd = lib.igImParseFormatFindEnd
M.ImParseFormatFindStart = lib.igImParseFormatFindStart
M.ImParseFormatPrecision = lib.igImParseFormatPrecision
M.ImParseFormatSanitizeForPrinting = lib.igImParseFormatSanitizeForPrinting
M.ImParseFormatSanitizeForScanning = lib.igImParseFormatSanitizeForScanning
M.ImParseFormatTrimDecorations = lib.igImParseFormatTrimDecorations
M.ImPow_Float = lib.igImPow_Float
M.ImPow_double = lib.igImPow_double
function M.ImPow(a1,a2) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImPow_Float(a1,a2) end
    if (ffi.istype('double',a1) or type(a1)=='number') then return M.ImPow_double(a1,a2) end
    print(a1,a2)
    error'M.ImPow could not find overloaded'
end
M.ImQsort = lib.igImQsort
function M.ImRotate(v,cos_a,sin_a)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImRotate(nonUDT_out,v,cos_a,sin_a)
    return nonUDT_out
end
M.ImRsqrt_Float = lib.igImRsqrt_Float
M.ImRsqrt_double = lib.igImRsqrt_double
function M.ImRsqrt(a1) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImRsqrt_Float(a1) end
    if (ffi.istype('double',a1) or type(a1)=='number') then return M.ImRsqrt_double(a1) end
    print(a1)
    error'M.ImRsqrt could not find overloaded'
end
M.ImSaturate = lib.igImSaturate
M.ImSign_Float = lib.igImSign_Float
M.ImSign_double = lib.igImSign_double
function M.ImSign(a1) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.ImSign_Float(a1) end
    if (ffi.istype('double',a1) or type(a1)=='number') then return M.ImSign_double(a1) end
    print(a1)
    error'M.ImSign could not find overloaded'
end
M.ImStrSkipBlank = lib.igImStrSkipBlank
M.ImStrTrimBlanks = lib.igImStrTrimBlanks
M.ImStrbolW = lib.igImStrbolW
M.ImStrchrRange = lib.igImStrchrRange
M.ImStrdup = lib.igImStrdup
M.ImStrdupcpy = lib.igImStrdupcpy
M.ImStreolRange = lib.igImStreolRange
M.ImStricmp = lib.igImStricmp
M.ImStristr = lib.igImStristr
M.ImStrlenW = lib.igImStrlenW
M.ImStrncpy = lib.igImStrncpy
M.ImStrnicmp = lib.igImStrnicmp
M.ImTextCharFromUtf8 = lib.igImTextCharFromUtf8
M.ImTextCharToUtf8 = lib.igImTextCharToUtf8
M.ImTextCountCharsFromUtf8 = lib.igImTextCountCharsFromUtf8
M.ImTextCountUtf8BytesFromChar = lib.igImTextCountUtf8BytesFromChar
M.ImTextCountUtf8BytesFromStr = lib.igImTextCountUtf8BytesFromStr
function M.ImTextStrFromUtf8(out_buf,out_buf_size,in_text,in_text_end,in_remaining)
    in_remaining = in_remaining or nil
    return lib.igImTextStrFromUtf8(out_buf,out_buf_size,in_text,in_text_end,in_remaining)
end
M.ImTextStrToUtf8 = lib.igImTextStrToUtf8
M.ImTriangleArea = lib.igImTriangleArea
M.ImTriangleBarycentricCoords = lib.igImTriangleBarycentricCoords
function M.ImTriangleClosestPoint(a,b,c,p)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igImTriangleClosestPoint(nonUDT_out,a,b,c,p)
    return nonUDT_out
end
M.ImTriangleContainsPoint = lib.igImTriangleContainsPoint
M.ImUpperPowerOfTwo = lib.igImUpperPowerOfTwo
function M.Image(user_texture_id,size,uv0,uv1,tint_col,border_col)
    border_col = border_col or ImVec4(0,0,0,0)
    tint_col = tint_col or ImVec4(1,1,1,1)
    uv0 = uv0 or ImVec2(0,0)
    uv1 = uv1 or ImVec2(1,1)
    return lib.igImage(user_texture_id,size,uv0,uv1,tint_col,border_col)
end
function M.ImageButton(user_texture_id,size,uv0,uv1,frame_padding,bg_col,tint_col)
    bg_col = bg_col or ImVec4(0,0,0,0)
    frame_padding = frame_padding or -1
    tint_col = tint_col or ImVec4(1,1,1,1)
    uv0 = uv0 or ImVec2(0,0)
    uv1 = uv1 or ImVec2(1,1)
    return lib.igImageButton(user_texture_id,size,uv0,uv1,frame_padding,bg_col,tint_col)
end
M.ImageButtonEx = lib.igImageButtonEx
function M.Indent(indent_w)
    indent_w = indent_w or 0.0
    return lib.igIndent(indent_w)
end
M.Initialize = lib.igInitialize
function M.InputDouble(label,v,step,step_fast,format,flags)
    flags = flags or 0
    format = format or "%.6f"
    step = step or 0
    step_fast = step_fast or 0
    return lib.igInputDouble(label,v,step,step_fast,format,flags)
end
function M.InputFloat(label,v,step,step_fast,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    step = step or 0.0
    step_fast = step_fast or 0.0
    return lib.igInputFloat(label,v,step,step_fast,format,flags)
end
function M.InputFloat2(label,v,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igInputFloat2(label,v,format,flags)
end
function M.InputFloat3(label,v,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igInputFloat3(label,v,format,flags)
end
function M.InputFloat4(label,v,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igInputFloat4(label,v,format,flags)
end
function M.InputInt(label,v,step,step_fast,flags)
    flags = flags or 0
    step = step or 1
    step_fast = step_fast or 100
    return lib.igInputInt(label,v,step,step_fast,flags)
end
function M.InputInt2(label,v,flags)
    flags = flags or 0
    return lib.igInputInt2(label,v,flags)
end
function M.InputInt3(label,v,flags)
    flags = flags or 0
    return lib.igInputInt3(label,v,flags)
end
function M.InputInt4(label,v,flags)
    flags = flags or 0
    return lib.igInputInt4(label,v,flags)
end
function M.InputScalar(label,data_type,p_data,p_step,p_step_fast,format,flags)
    flags = flags or 0
    format = format or nil
    p_step = p_step or nil
    p_step_fast = p_step_fast or nil
    return lib.igInputScalar(label,data_type,p_data,p_step,p_step_fast,format,flags)
end
function M.InputScalarN(label,data_type,p_data,components,p_step,p_step_fast,format,flags)
    flags = flags or 0
    format = format or nil
    p_step = p_step or nil
    p_step_fast = p_step_fast or nil
    return lib.igInputScalarN(label,data_type,p_data,components,p_step,p_step_fast,format,flags)
end
function M.InputText(label,buf,buf_size,flags,callback,user_data)
    callback = callback or nil
    flags = flags or 0
    user_data = user_data or nil
    return lib.igInputText(label,buf,buf_size,flags,callback,user_data)
end
function M.InputTextEx(label,hint,buf,buf_size,size_arg,flags,callback,user_data)
    callback = callback or nil
    user_data = user_data or nil
    return lib.igInputTextEx(label,hint,buf,buf_size,size_arg,flags,callback,user_data)
end
function M.InputTextMultiline(label,buf,buf_size,size,flags,callback,user_data)
    callback = callback or nil
    flags = flags or 0
    size = size or ImVec2(0,0)
    user_data = user_data or nil
    return lib.igInputTextMultiline(label,buf,buf_size,size,flags,callback,user_data)
end
function M.InputTextWithHint(label,hint,buf,buf_size,flags,callback,user_data)
    callback = callback or nil
    flags = flags or 0
    user_data = user_data or nil
    return lib.igInputTextWithHint(label,hint,buf,buf_size,flags,callback,user_data)
end
function M.InvisibleButton(str_id,size,flags)
    flags = flags or 0
    return lib.igInvisibleButton(str_id,size,flags)
end
M.IsActiveIdUsingKey = lib.igIsActiveIdUsingKey
M.IsActiveIdUsingNavDir = lib.igIsActiveIdUsingNavDir
M.IsActiveIdUsingNavInput = lib.igIsActiveIdUsingNavInput
M.IsAnyItemActive = lib.igIsAnyItemActive
M.IsAnyItemFocused = lib.igIsAnyItemFocused
M.IsAnyItemHovered = lib.igIsAnyItemHovered
M.IsAnyMouseDown = lib.igIsAnyMouseDown
M.IsClippedEx = lib.igIsClippedEx
M.IsDragDropActive = lib.igIsDragDropActive
M.IsDragDropPayloadBeingAccepted = lib.igIsDragDropPayloadBeingAccepted
M.IsGamepadKey = lib.igIsGamepadKey
M.IsItemActivated = lib.igIsItemActivated
M.IsItemActive = lib.igIsItemActive
function M.IsItemClicked(mouse_button)
    mouse_button = mouse_button or 0
    return lib.igIsItemClicked(mouse_button)
end
M.IsItemDeactivated = lib.igIsItemDeactivated
M.IsItemDeactivatedAfterEdit = lib.igIsItemDeactivatedAfterEdit
M.IsItemEdited = lib.igIsItemEdited
M.IsItemFocused = lib.igIsItemFocused
function M.IsItemHovered(flags)
    flags = flags or 0
    return lib.igIsItemHovered(flags)
end
M.IsItemToggledOpen = lib.igIsItemToggledOpen
M.IsItemToggledSelection = lib.igIsItemToggledSelection
M.IsItemVisible = lib.igIsItemVisible
M.IsKeyDown = lib.igIsKeyDown
function M.IsKeyPressed(key,_repeat)
    if _repeat == nil then _repeat = true end
    return lib.igIsKeyPressed(key,_repeat)
end
function M.IsKeyPressedMap(key,_repeat)
    if _repeat == nil then _repeat = true end
    return lib.igIsKeyPressedMap(key,_repeat)
end
M.IsKeyReleased = lib.igIsKeyReleased
M.IsLegacyKey = lib.igIsLegacyKey
function M.IsMouseClicked(button,_repeat)
    _repeat = _repeat or false
    return lib.igIsMouseClicked(button,_repeat)
end
M.IsMouseDoubleClicked = lib.igIsMouseDoubleClicked
M.IsMouseDown = lib.igIsMouseDown
function M.IsMouseDragPastThreshold(button,lock_threshold)
    lock_threshold = lock_threshold or -1.0
    return lib.igIsMouseDragPastThreshold(button,lock_threshold)
end
function M.IsMouseDragging(button,lock_threshold)
    lock_threshold = lock_threshold or -1.0
    return lib.igIsMouseDragging(button,lock_threshold)
end
function M.IsMouseHoveringRect(r_min,r_max,clip)
    if clip == nil then clip = true end
    return lib.igIsMouseHoveringRect(r_min,r_max,clip)
end
function M.IsMousePosValid(mouse_pos)
    mouse_pos = mouse_pos or nil
    return lib.igIsMousePosValid(mouse_pos)
end
M.IsMouseReleased = lib.igIsMouseReleased
M.IsNamedKey = lib.igIsNamedKey
M.IsNavInputDown = lib.igIsNavInputDown
M.IsNavInputTest = lib.igIsNavInputTest
function M.IsPopupOpen_Str(str_id,flags)
    flags = flags or 0
    return lib.igIsPopupOpen_Str(str_id,flags)
end
M.IsPopupOpen_ID = lib.igIsPopupOpen_ID
function M.IsPopupOpen(a1,a2) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.IsPopupOpen_Str(a1,a2) end
    if ffi.istype('ImGuiID',a1) then return M.IsPopupOpen_ID(a1,a2) end
    print(a1,a2)
    error'M.IsPopupOpen could not find overloaded'
end
M.IsRectVisible_Nil = lib.igIsRectVisible_Nil
M.IsRectVisible_Vec2 = lib.igIsRectVisible_Vec2
function M.IsRectVisible(a1,a2) -- generic version
    if a2==nil then return M.IsRectVisible_Nil(a1) end
    if ffi.istype('const ImVec2',a2) then return M.IsRectVisible_Vec2(a1,a2) end
    print(a1,a2)
    error'M.IsRectVisible could not find overloaded'
end
M.IsWindowAbove = lib.igIsWindowAbove
M.IsWindowAppearing = lib.igIsWindowAppearing
M.IsWindowChildOf = lib.igIsWindowChildOf
M.IsWindowCollapsed = lib.igIsWindowCollapsed
M.IsWindowDocked = lib.igIsWindowDocked
function M.IsWindowFocused(flags)
    flags = flags or 0
    return lib.igIsWindowFocused(flags)
end
function M.IsWindowHovered(flags)
    flags = flags or 0
    return lib.igIsWindowHovered(flags)
end
M.IsWindowNavFocusable = lib.igIsWindowNavFocusable
M.IsWindowWithinBeginStackOf = lib.igIsWindowWithinBeginStackOf
function M.ItemAdd(bb,id,nav_bb,extra_flags)
    extra_flags = extra_flags or 0
    nav_bb = nav_bb or nil
    return lib.igItemAdd(bb,id,nav_bb,extra_flags)
end
M.ItemHoverable = lib.igItemHoverable
function M.ItemSize_Vec2(size,text_baseline_y)
    text_baseline_y = text_baseline_y or -1.0
    return lib.igItemSize_Vec2(size,text_baseline_y)
end
function M.ItemSize_Rect(bb,text_baseline_y)
    text_baseline_y = text_baseline_y or -1.0
    return lib.igItemSize_Rect(bb,text_baseline_y)
end
function M.ItemSize(a1,a2) -- generic version
    if ffi.istype('const ImVec2',a1) then return M.ItemSize_Vec2(a1,a2) end
    if ffi.istype('const ImRect',a1) then return M.ItemSize_Rect(a1,a2) end
    print(a1,a2)
    error'M.ItemSize could not find overloaded'
end
M.KeepAliveID = lib.igKeepAliveID
M.LabelText = lib.igLabelText
M.LabelTextV = lib.igLabelTextV
function M.ListBox_Str_arr(label,current_item,items,items_count,height_in_items)
    height_in_items = height_in_items or -1
    return lib.igListBox_Str_arr(label,current_item,items,items_count,height_in_items)
end
function M.ListBox_FnBoolPtr(label,current_item,items_getter,data,items_count,height_in_items)
    height_in_items = height_in_items or -1
    return lib.igListBox_FnBoolPtr(label,current_item,items_getter,data,items_count,height_in_items)
end
function M.ListBox(a1,a2,a3,a4,a5,a6) -- generic version
    if (ffi.istype('const char* const[]',a3) or ffi.istype('const char const[]',a3) or ffi.istype('const char const[][]',a3)) then return M.ListBox_Str_arr(a1,a2,a3,a4,a5) end
    if ffi.istype('bool(*)(void* data,int idx,const char** out_text)',a3) then return M.ListBox_FnBoolPtr(a1,a2,a3,a4,a5,a6) end
    print(a1,a2,a3,a4,a5,a6)
    error'M.ListBox could not find overloaded'
end
M.LoadIniSettingsFromDisk = lib.igLoadIniSettingsFromDisk
function M.LoadIniSettingsFromMemory(ini_data,ini_size)
    ini_size = ini_size or 0
    return lib.igLoadIniSettingsFromMemory(ini_data,ini_size)
end
M.LogBegin = lib.igLogBegin
M.LogButtons = lib.igLogButtons
M.LogFinish = lib.igLogFinish
function M.LogRenderedText(ref_pos,text,text_end)
    text_end = text_end or nil
    return lib.igLogRenderedText(ref_pos,text,text_end)
end
M.LogSetNextTextDecoration = lib.igLogSetNextTextDecoration
M.LogText = lib.igLogText
M.LogTextV = lib.igLogTextV
function M.LogToBuffer(auto_open_depth)
    auto_open_depth = auto_open_depth or -1
    return lib.igLogToBuffer(auto_open_depth)
end
function M.LogToClipboard(auto_open_depth)
    auto_open_depth = auto_open_depth or -1
    return lib.igLogToClipboard(auto_open_depth)
end
function M.LogToFile(auto_open_depth,filename)
    auto_open_depth = auto_open_depth or -1
    filename = filename or nil
    return lib.igLogToFile(auto_open_depth,filename)
end
function M.LogToTTY(auto_open_depth)
    auto_open_depth = auto_open_depth or -1
    return lib.igLogToTTY(auto_open_depth)
end
M.MarkIniSettingsDirty_Nil = lib.igMarkIniSettingsDirty_Nil
M.MarkIniSettingsDirty_WindowPtr = lib.igMarkIniSettingsDirty_WindowPtr
function M.MarkIniSettingsDirty(a1) -- generic version
    if a1==nil then return M.MarkIniSettingsDirty_Nil() end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.MarkIniSettingsDirty_WindowPtr(a1) end
    print(a1)
    error'M.MarkIniSettingsDirty could not find overloaded'
end
M.MarkItemEdited = lib.igMarkItemEdited
M.MemAlloc = lib.igMemAlloc
M.MemFree = lib.igMemFree
function M.MenuItem_Bool(label,shortcut,selected,enabled)
    if enabled == nil then enabled = true end
    selected = selected or false
    shortcut = shortcut or nil
    return lib.igMenuItem_Bool(label,shortcut,selected,enabled)
end
function M.MenuItem_BoolPtr(label,shortcut,p_selected,enabled)
    if enabled == nil then enabled = true end
    return lib.igMenuItem_BoolPtr(label,shortcut,p_selected,enabled)
end
function M.MenuItem(a1,a2,a3,a4) -- generic version
    if ((ffi.istype('bool',a3) or type(a3)=='boolean') or type(a3)=='nil') then return M.MenuItem_Bool(a1,a2,a3,a4) end
    if (ffi.istype('bool*',a3) or ffi.istype('bool',a3) or ffi.istype('bool[]',a3)) then return M.MenuItem_BoolPtr(a1,a2,a3,a4) end
    print(a1,a2,a3,a4)
    error'M.MenuItem could not find overloaded'
end
function M.MenuItemEx(label,icon,shortcut,selected,enabled)
    if enabled == nil then enabled = true end
    selected = selected or false
    shortcut = shortcut or nil
    return lib.igMenuItemEx(label,icon,shortcut,selected,enabled)
end
M.NavInitRequestApplyResult = lib.igNavInitRequestApplyResult
M.NavInitWindow = lib.igNavInitWindow
M.NavMoveRequestApplyResult = lib.igNavMoveRequestApplyResult
M.NavMoveRequestButNoResultYet = lib.igNavMoveRequestButNoResultYet
M.NavMoveRequestCancel = lib.igNavMoveRequestCancel
M.NavMoveRequestForward = lib.igNavMoveRequestForward
M.NavMoveRequestResolveWithLastItem = lib.igNavMoveRequestResolveWithLastItem
M.NavMoveRequestSubmit = lib.igNavMoveRequestSubmit
M.NavMoveRequestTryWrapping = lib.igNavMoveRequestTryWrapping
M.NewFrame = lib.igNewFrame
M.NewLine = lib.igNewLine
M.NextColumn = lib.igNextColumn
function M.OpenPopup_Str(str_id,popup_flags)
    popup_flags = popup_flags or 0
    return lib.igOpenPopup_Str(str_id,popup_flags)
end
function M.OpenPopup_ID(id,popup_flags)
    popup_flags = popup_flags or 0
    return lib.igOpenPopup_ID(id,popup_flags)
end
function M.OpenPopup(a1,a2) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.OpenPopup_Str(a1,a2) end
    if ffi.istype('ImGuiID',a1) then return M.OpenPopup_ID(a1,a2) end
    print(a1,a2)
    error'M.OpenPopup could not find overloaded'
end
function M.OpenPopupEx(id,popup_flags)
    popup_flags = popup_flags or 0
    return lib.igOpenPopupEx(id,popup_flags)
end
function M.OpenPopupOnItemClick(str_id,popup_flags)
    popup_flags = popup_flags or 1
    str_id = str_id or nil
    return lib.igOpenPopupOnItemClick(str_id,popup_flags)
end
M.PlotEx = lib.igPlotEx
function M.PlotHistogram_FloatPtr(label,values,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size,stride)
    graph_size = graph_size or ImVec2(0,0)
    overlay_text = overlay_text or nil
    scale_max = scale_max or M.FLT_MAX
    scale_min = scale_min or M.FLT_MAX
    stride = stride or ffi.sizeof("float")
    values_offset = values_offset or 0
    return lib.igPlotHistogram_FloatPtr(label,values,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size,stride)
end
function M.PlotHistogram_FnFloatPtr(label,values_getter,data,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size)
    graph_size = graph_size or ImVec2(0,0)
    overlay_text = overlay_text or nil
    scale_max = scale_max or M.FLT_MAX
    scale_min = scale_min or M.FLT_MAX
    values_offset = values_offset or 0
    return lib.igPlotHistogram_FnFloatPtr(label,values_getter,data,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size)
end
function M.PlotHistogram(a1,a2,a3,a4,a5,a6,a7,a8,a9) -- generic version
    if (ffi.istype('const float*',a2) or ffi.istype('float[]',a2)) then return M.PlotHistogram_FloatPtr(a1,a2,a3,a4,a5,a6,a7,a8,a9) end
    if ffi.istype('float(*)(void* data,int idx)',a2) then return M.PlotHistogram_FnFloatPtr(a1,a2,a3,a4,a5,a6,a7,a8,a9) end
    print(a1,a2,a3,a4,a5,a6,a7,a8,a9)
    error'M.PlotHistogram could not find overloaded'
end
function M.PlotLines_FloatPtr(label,values,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size,stride)
    graph_size = graph_size or ImVec2(0,0)
    overlay_text = overlay_text or nil
    scale_max = scale_max or M.FLT_MAX
    scale_min = scale_min or M.FLT_MAX
    stride = stride or ffi.sizeof("float")
    values_offset = values_offset or 0
    return lib.igPlotLines_FloatPtr(label,values,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size,stride)
end
function M.PlotLines_FnFloatPtr(label,values_getter,data,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size)
    graph_size = graph_size or ImVec2(0,0)
    overlay_text = overlay_text or nil
    scale_max = scale_max or M.FLT_MAX
    scale_min = scale_min or M.FLT_MAX
    values_offset = values_offset or 0
    return lib.igPlotLines_FnFloatPtr(label,values_getter,data,values_count,values_offset,overlay_text,scale_min,scale_max,graph_size)
end
function M.PlotLines(a1,a2,a3,a4,a5,a6,a7,a8,a9) -- generic version
    if (ffi.istype('const float*',a2) or ffi.istype('float[]',a2)) then return M.PlotLines_FloatPtr(a1,a2,a3,a4,a5,a6,a7,a8,a9) end
    if ffi.istype('float(*)(void* data,int idx)',a2) then return M.PlotLines_FnFloatPtr(a1,a2,a3,a4,a5,a6,a7,a8,a9) end
    print(a1,a2,a3,a4,a5,a6,a7,a8,a9)
    error'M.PlotLines could not find overloaded'
end
M.PopAllowKeyboardFocus = lib.igPopAllowKeyboardFocus
M.PopButtonRepeat = lib.igPopButtonRepeat
M.PopClipRect = lib.igPopClipRect
M.PopColumnsBackground = lib.igPopColumnsBackground
M.PopFocusScope = lib.igPopFocusScope
M.PopFont = lib.igPopFont
M.PopID = lib.igPopID
M.PopItemFlag = lib.igPopItemFlag
M.PopItemWidth = lib.igPopItemWidth
function M.PopStyleColor(count)
    count = count or 1
    return lib.igPopStyleColor(count)
end
function M.PopStyleVar(count)
    count = count or 1
    return lib.igPopStyleVar(count)
end
M.PopTextWrapPos = lib.igPopTextWrapPos
function M.ProgressBar(fraction,size_arg,overlay)
    overlay = overlay or nil
    size_arg = size_arg or ImVec2(-M.FLT_MIN,0)
    return lib.igProgressBar(fraction,size_arg,overlay)
end
M.PushAllowKeyboardFocus = lib.igPushAllowKeyboardFocus
M.PushButtonRepeat = lib.igPushButtonRepeat
M.PushClipRect = lib.igPushClipRect
M.PushColumnClipRect = lib.igPushColumnClipRect
M.PushColumnsBackground = lib.igPushColumnsBackground
M.PushFocusScope = lib.igPushFocusScope
M.PushFont = lib.igPushFont
M.PushID_Str = lib.igPushID_Str
M.PushID_StrStr = lib.igPushID_StrStr
M.PushID_Ptr = lib.igPushID_Ptr
M.PushID_Int = lib.igPushID_Int
function M.PushID(a1,a2) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and a2==nil then return M.PushID_Str(a1) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and (ffi.istype('const char*',a2) or ffi.istype('char[]',a2) or type(a2)=='string') then return M.PushID_StrStr(a1,a2) end
    if ffi.istype('const void*',a1) then return M.PushID_Ptr(a1) end
    if (ffi.istype('int',a1) or type(a1)=='number') then return M.PushID_Int(a1) end
    print(a1,a2)
    error'M.PushID could not find overloaded'
end
M.PushItemFlag = lib.igPushItemFlag
M.PushItemWidth = lib.igPushItemWidth
M.PushMultiItemsWidths = lib.igPushMultiItemsWidths
M.PushOverrideID = lib.igPushOverrideID
M.PushStyleColor_U32 = lib.igPushStyleColor_U32
M.PushStyleColor_Vec4 = lib.igPushStyleColor_Vec4
function M.PushStyleColor(a1,a2) -- generic version
    if (ffi.istype('ImU32',a2) or type(a2)=='number') then return M.PushStyleColor_U32(a1,a2) end
    if ffi.istype('const ImVec4',a2) then return M.PushStyleColor_Vec4(a1,a2) end
    print(a1,a2)
    error'M.PushStyleColor could not find overloaded'
end
M.PushStyleVar_Float = lib.igPushStyleVar_Float
M.PushStyleVar_Vec2 = lib.igPushStyleVar_Vec2
function M.PushStyleVar(a1,a2) -- generic version
    if (ffi.istype('float',a2) or type(a2)=='number') then return M.PushStyleVar_Float(a1,a2) end
    if ffi.istype('const ImVec2',a2) then return M.PushStyleVar_Vec2(a1,a2) end
    print(a1,a2)
    error'M.PushStyleVar could not find overloaded'
end
function M.PushTextWrapPos(wrap_local_pos_x)
    wrap_local_pos_x = wrap_local_pos_x or 0.0
    return lib.igPushTextWrapPos(wrap_local_pos_x)
end
M.RadioButton_Bool = lib.igRadioButton_Bool
M.RadioButton_IntPtr = lib.igRadioButton_IntPtr
function M.RadioButton(a1,a2,a3) -- generic version
    if (ffi.istype('bool',a2) or type(a2)=='boolean') then return M.RadioButton_Bool(a1,a2) end
    if (ffi.istype('int*',a2) or ffi.istype('int[]',a2)) then return M.RadioButton_IntPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.RadioButton could not find overloaded'
end
M.RemoveContextHook = lib.igRemoveContextHook
M.RemoveSettingsHandler = lib.igRemoveSettingsHandler
M.Render = lib.igRender
function M.RenderArrow(draw_list,pos,col,dir,scale)
    scale = scale or 1.0
    return lib.igRenderArrow(draw_list,pos,col,dir,scale)
end
M.RenderArrowDockMenu = lib.igRenderArrowDockMenu
M.RenderArrowPointingAt = lib.igRenderArrowPointingAt
M.RenderBullet = lib.igRenderBullet
M.RenderCheckMark = lib.igRenderCheckMark
function M.RenderColorRectWithAlphaCheckerboard(draw_list,p_min,p_max,fill_col,grid_step,grid_off,rounding,flags)
    flags = flags or 0
    rounding = rounding or 0.0
    return lib.igRenderColorRectWithAlphaCheckerboard(draw_list,p_min,p_max,fill_col,grid_step,grid_off,rounding,flags)
end
function M.RenderFrame(p_min,p_max,fill_col,border,rounding)
    if border == nil then border = true end
    rounding = rounding or 0.0
    return lib.igRenderFrame(p_min,p_max,fill_col,border,rounding)
end
function M.RenderFrameBorder(p_min,p_max,rounding)
    rounding = rounding or 0.0
    return lib.igRenderFrameBorder(p_min,p_max,rounding)
end
M.RenderMouseCursor = lib.igRenderMouseCursor
function M.RenderNavHighlight(bb,id,flags)
    flags = flags or 1
    return lib.igRenderNavHighlight(bb,id,flags)
end
function M.RenderPlatformWindowsDefault(platform_render_arg,renderer_render_arg)
    platform_render_arg = platform_render_arg or nil
    renderer_render_arg = renderer_render_arg or nil
    return lib.igRenderPlatformWindowsDefault(platform_render_arg,renderer_render_arg)
end
M.RenderRectFilledRangeH = lib.igRenderRectFilledRangeH
M.RenderRectFilledWithHole = lib.igRenderRectFilledWithHole
function M.RenderText(pos,text,text_end,hide_text_after_hash)
    if hide_text_after_hash == nil then hide_text_after_hash = true end
    text_end = text_end or nil
    return lib.igRenderText(pos,text,text_end,hide_text_after_hash)
end
function M.RenderTextClipped(pos_min,pos_max,text,text_end,text_size_if_known,align,clip_rect)
    align = align or ImVec2(0,0)
    clip_rect = clip_rect or nil
    return lib.igRenderTextClipped(pos_min,pos_max,text,text_end,text_size_if_known,align,clip_rect)
end
function M.RenderTextClippedEx(draw_list,pos_min,pos_max,text,text_end,text_size_if_known,align,clip_rect)
    align = align or ImVec2(0,0)
    clip_rect = clip_rect or nil
    return lib.igRenderTextClippedEx(draw_list,pos_min,pos_max,text,text_end,text_size_if_known,align,clip_rect)
end
M.RenderTextEllipsis = lib.igRenderTextEllipsis
M.RenderTextWrapped = lib.igRenderTextWrapped
function M.ResetMouseDragDelta(button)
    button = button or 0
    return lib.igResetMouseDragDelta(button)
end
function M.SameLine(offset_from_start_x,spacing)
    offset_from_start_x = offset_from_start_x or 0.0
    spacing = spacing or -1.0
    return lib.igSameLine(offset_from_start_x,spacing)
end
M.SaveIniSettingsToDisk = lib.igSaveIniSettingsToDisk
function M.SaveIniSettingsToMemory(out_ini_size)
    out_ini_size = out_ini_size or nil
    return lib.igSaveIniSettingsToMemory(out_ini_size)
end
M.ScaleWindowsInViewport = lib.igScaleWindowsInViewport
M.ScrollToBringRectIntoView = lib.igScrollToBringRectIntoView
function M.ScrollToItem(flags)
    flags = flags or 0
    return lib.igScrollToItem(flags)
end
function M.ScrollToRect(window,rect,flags)
    flags = flags or 0
    return lib.igScrollToRect(window,rect,flags)
end
function M.ScrollToRectEx(window,rect,flags)
    flags = flags or 0
    local nonUDT_out = ffi.new("ImVec2")
    lib.igScrollToRectEx(nonUDT_out,window,rect,flags)
    return nonUDT_out
end
M.Scrollbar = lib.igScrollbar
M.ScrollbarEx = lib.igScrollbarEx
function M.Selectable_Bool(label,selected,flags,size)
    flags = flags or 0
    selected = selected or false
    size = size or ImVec2(0,0)
    return lib.igSelectable_Bool(label,selected,flags,size)
end
function M.Selectable_BoolPtr(label,p_selected,flags,size)
    flags = flags or 0
    size = size or ImVec2(0,0)
    return lib.igSelectable_BoolPtr(label,p_selected,flags,size)
end
function M.Selectable(a1,a2,a3,a4) -- generic version
    if ((ffi.istype('bool',a2) or type(a2)=='boolean') or type(a2)=='nil') then return M.Selectable_Bool(a1,a2,a3,a4) end
    if (ffi.istype('bool*',a2) or ffi.istype('bool',a2) or ffi.istype('bool[]',a2)) then return M.Selectable_BoolPtr(a1,a2,a3,a4) end
    print(a1,a2,a3,a4)
    error'M.Selectable could not find overloaded'
end
M.Separator = lib.igSeparator
M.SeparatorEx = lib.igSeparatorEx
M.SetActiveID = lib.igSetActiveID
M.SetActiveIdUsingKey = lib.igSetActiveIdUsingKey
M.SetActiveIdUsingNavAndKeys = lib.igSetActiveIdUsingNavAndKeys
function M.SetAllocatorFunctions(alloc_func,free_func,user_data)
    user_data = user_data or nil
    return lib.igSetAllocatorFunctions(alloc_func,free_func,user_data)
end
M.SetClipboardText = lib.igSetClipboardText
M.SetColorEditOptions = lib.igSetColorEditOptions
M.SetColumnOffset = lib.igSetColumnOffset
M.SetColumnWidth = lib.igSetColumnWidth
M.SetCurrentContext = lib.igSetCurrentContext
M.SetCurrentFont = lib.igSetCurrentFont
M.SetCurrentViewport = lib.igSetCurrentViewport
M.SetCursorPos = lib.igSetCursorPos
M.SetCursorPosX = lib.igSetCursorPosX
M.SetCursorPosY = lib.igSetCursorPosY
M.SetCursorScreenPos = lib.igSetCursorScreenPos
function M.SetDragDropPayload(type,data,sz,cond)
    cond = cond or 0
    return lib.igSetDragDropPayload(type,data,sz,cond)
end
M.SetFocusID = lib.igSetFocusID
M.SetHoveredID = lib.igSetHoveredID
M.SetItemAllowOverlap = lib.igSetItemAllowOverlap
M.SetItemDefaultFocus = lib.igSetItemDefaultFocus
M.SetItemUsingMouseWheel = lib.igSetItemUsingMouseWheel
function M.SetKeyboardFocusHere(offset)
    offset = offset or 0
    return lib.igSetKeyboardFocusHere(offset)
end
M.SetLastItemData = lib.igSetLastItemData
M.SetMouseCursor = lib.igSetMouseCursor
M.SetNavID = lib.igSetNavID
M.SetNavWindow = lib.igSetNavWindow
M.SetNextFrameWantCaptureKeyboard = lib.igSetNextFrameWantCaptureKeyboard
M.SetNextFrameWantCaptureMouse = lib.igSetNextFrameWantCaptureMouse
function M.SetNextItemOpen(is_open,cond)
    cond = cond or 0
    return lib.igSetNextItemOpen(is_open,cond)
end
M.SetNextItemWidth = lib.igSetNextItemWidth
M.SetNextWindowBgAlpha = lib.igSetNextWindowBgAlpha
M.SetNextWindowClass = lib.igSetNextWindowClass
function M.SetNextWindowCollapsed(collapsed,cond)
    cond = cond or 0
    return lib.igSetNextWindowCollapsed(collapsed,cond)
end
M.SetNextWindowContentSize = lib.igSetNextWindowContentSize
function M.SetNextWindowDockID(dock_id,cond)
    cond = cond or 0
    return lib.igSetNextWindowDockID(dock_id,cond)
end
M.SetNextWindowFocus = lib.igSetNextWindowFocus
function M.SetNextWindowPos(pos,cond,pivot)
    cond = cond or 0
    pivot = pivot or ImVec2(0,0)
    return lib.igSetNextWindowPos(pos,cond,pivot)
end
M.SetNextWindowScroll = lib.igSetNextWindowScroll
function M.SetNextWindowSize(size,cond)
    cond = cond or 0
    return lib.igSetNextWindowSize(size,cond)
end
function M.SetNextWindowSizeConstraints(size_min,size_max,custom_callback,custom_callback_data)
    custom_callback = custom_callback or nil
    custom_callback_data = custom_callback_data or nil
    return lib.igSetNextWindowSizeConstraints(size_min,size_max,custom_callback,custom_callback_data)
end
M.SetNextWindowViewport = lib.igSetNextWindowViewport
function M.SetScrollFromPosX_Float(local_x,center_x_ratio)
    center_x_ratio = center_x_ratio or 0.5
    return lib.igSetScrollFromPosX_Float(local_x,center_x_ratio)
end
M.SetScrollFromPosX_WindowPtr = lib.igSetScrollFromPosX_WindowPtr
function M.SetScrollFromPosX(a1,a2,a3) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.SetScrollFromPosX_Float(a1,a2) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetScrollFromPosX_WindowPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.SetScrollFromPosX could not find overloaded'
end
function M.SetScrollFromPosY_Float(local_y,center_y_ratio)
    center_y_ratio = center_y_ratio or 0.5
    return lib.igSetScrollFromPosY_Float(local_y,center_y_ratio)
end
M.SetScrollFromPosY_WindowPtr = lib.igSetScrollFromPosY_WindowPtr
function M.SetScrollFromPosY(a1,a2,a3) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.SetScrollFromPosY_Float(a1,a2) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetScrollFromPosY_WindowPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.SetScrollFromPosY could not find overloaded'
end
function M.SetScrollHereX(center_x_ratio)
    center_x_ratio = center_x_ratio or 0.5
    return lib.igSetScrollHereX(center_x_ratio)
end
function M.SetScrollHereY(center_y_ratio)
    center_y_ratio = center_y_ratio or 0.5
    return lib.igSetScrollHereY(center_y_ratio)
end
M.SetScrollX_Float = lib.igSetScrollX_Float
M.SetScrollX_WindowPtr = lib.igSetScrollX_WindowPtr
function M.SetScrollX(a1,a2) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.SetScrollX_Float(a1) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetScrollX_WindowPtr(a1,a2) end
    print(a1,a2)
    error'M.SetScrollX could not find overloaded'
end
M.SetScrollY_Float = lib.igSetScrollY_Float
M.SetScrollY_WindowPtr = lib.igSetScrollY_WindowPtr
function M.SetScrollY(a1,a2) -- generic version
    if (ffi.istype('float',a1) or type(a1)=='number') then return M.SetScrollY_Float(a1) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetScrollY_WindowPtr(a1,a2) end
    print(a1,a2)
    error'M.SetScrollY could not find overloaded'
end
M.SetStateStorage = lib.igSetStateStorage
M.SetTabItemClosed = lib.igSetTabItemClosed
M.SetTooltip = lib.igSetTooltip
M.SetTooltipV = lib.igSetTooltipV
M.SetWindowClipRectBeforeSetChannel = lib.igSetWindowClipRectBeforeSetChannel
function M.SetWindowCollapsed_Bool(collapsed,cond)
    cond = cond or 0
    return lib.igSetWindowCollapsed_Bool(collapsed,cond)
end
function M.SetWindowCollapsed_Str(name,collapsed,cond)
    cond = cond or 0
    return lib.igSetWindowCollapsed_Str(name,collapsed,cond)
end
function M.SetWindowCollapsed_WindowPtr(window,collapsed,cond)
    cond = cond or 0
    return lib.igSetWindowCollapsed_WindowPtr(window,collapsed,cond)
end
function M.SetWindowCollapsed(a1,a2,a3) -- generic version
    if (ffi.istype('bool',a1) or type(a1)=='boolean') then return M.SetWindowCollapsed_Bool(a1,a2) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.SetWindowCollapsed_Str(a1,a2,a3) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetWindowCollapsed_WindowPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.SetWindowCollapsed could not find overloaded'
end
M.SetWindowDock = lib.igSetWindowDock
M.SetWindowFocus_Nil = lib.igSetWindowFocus_Nil
M.SetWindowFocus_Str = lib.igSetWindowFocus_Str
function M.SetWindowFocus(a1) -- generic version
    if a1==nil then return M.SetWindowFocus_Nil() end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.SetWindowFocus_Str(a1) end
    print(a1)
    error'M.SetWindowFocus could not find overloaded'
end
M.SetWindowFontScale = lib.igSetWindowFontScale
M.SetWindowHitTestHole = lib.igSetWindowHitTestHole
function M.SetWindowPos_Vec2(pos,cond)
    cond = cond or 0
    return lib.igSetWindowPos_Vec2(pos,cond)
end
function M.SetWindowPos_Str(name,pos,cond)
    cond = cond or 0
    return lib.igSetWindowPos_Str(name,pos,cond)
end
function M.SetWindowPos_WindowPtr(window,pos,cond)
    cond = cond or 0
    return lib.igSetWindowPos_WindowPtr(window,pos,cond)
end
function M.SetWindowPos(a1,a2,a3) -- generic version
    if ffi.istype('const ImVec2',a1) then return M.SetWindowPos_Vec2(a1,a2) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.SetWindowPos_Str(a1,a2,a3) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetWindowPos_WindowPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.SetWindowPos could not find overloaded'
end
function M.SetWindowSize_Vec2(size,cond)
    cond = cond or 0
    return lib.igSetWindowSize_Vec2(size,cond)
end
function M.SetWindowSize_Str(name,size,cond)
    cond = cond or 0
    return lib.igSetWindowSize_Str(name,size,cond)
end
function M.SetWindowSize_WindowPtr(window,size,cond)
    cond = cond or 0
    return lib.igSetWindowSize_WindowPtr(window,size,cond)
end
function M.SetWindowSize(a1,a2,a3) -- generic version
    if ffi.istype('const ImVec2',a1) then return M.SetWindowSize_Vec2(a1,a2) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.SetWindowSize_Str(a1,a2,a3) end
    if (ffi.istype('ImGuiWindow*',a1) or ffi.istype('ImGuiWindow',a1) or ffi.istype('ImGuiWindow[]',a1)) then return M.SetWindowSize_WindowPtr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.SetWindowSize could not find overloaded'
end
M.SetWindowViewport = lib.igSetWindowViewport
M.ShadeVertsLinearColorGradientKeepAlpha = lib.igShadeVertsLinearColorGradientKeepAlpha
M.ShadeVertsLinearUV = lib.igShadeVertsLinearUV
function M.ShowAboutWindow(p_open)
    p_open = p_open or nil
    return lib.igShowAboutWindow(p_open)
end
function M.ShowDebugLogWindow(p_open)
    p_open = p_open or nil
    return lib.igShowDebugLogWindow(p_open)
end
function M.ShowDemoWindow(p_open)
    p_open = p_open or nil
    return lib.igShowDemoWindow(p_open)
end
M.ShowFontAtlas = lib.igShowFontAtlas
M.ShowFontSelector = lib.igShowFontSelector
function M.ShowMetricsWindow(p_open)
    p_open = p_open or nil
    return lib.igShowMetricsWindow(p_open)
end
function M.ShowStackToolWindow(p_open)
    p_open = p_open or nil
    return lib.igShowStackToolWindow(p_open)
end
function M.ShowStyleEditor(ref)
    ref = ref or nil
    return lib.igShowStyleEditor(ref)
end
M.ShowStyleSelector = lib.igShowStyleSelector
M.ShowUserGuide = lib.igShowUserGuide
M.ShrinkWidths = lib.igShrinkWidths
M.Shutdown = lib.igShutdown
function M.SliderAngle(label,v_rad,v_degrees_min,v_degrees_max,format,flags)
    flags = flags or 0
    format = format or "%.0f deg"
    v_degrees_max = v_degrees_max or 360.0
    v_degrees_min = v_degrees_min or -360.0
    return lib.igSliderAngle(label,v_rad,v_degrees_min,v_degrees_max,format,flags)
end
M.SliderBehavior = lib.igSliderBehavior
function M.SliderFloat(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igSliderFloat(label,v,v_min,v_max,format,flags)
end
function M.SliderFloat2(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igSliderFloat2(label,v,v_min,v_max,format,flags)
end
function M.SliderFloat3(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igSliderFloat3(label,v,v_min,v_max,format,flags)
end
function M.SliderFloat4(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igSliderFloat4(label,v,v_min,v_max,format,flags)
end
function M.SliderInt(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    return lib.igSliderInt(label,v,v_min,v_max,format,flags)
end
function M.SliderInt2(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    return lib.igSliderInt2(label,v,v_min,v_max,format,flags)
end
function M.SliderInt3(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    return lib.igSliderInt3(label,v,v_min,v_max,format,flags)
end
function M.SliderInt4(label,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    return lib.igSliderInt4(label,v,v_min,v_max,format,flags)
end
function M.SliderScalar(label,data_type,p_data,p_min,p_max,format,flags)
    flags = flags or 0
    format = format or nil
    return lib.igSliderScalar(label,data_type,p_data,p_min,p_max,format,flags)
end
function M.SliderScalarN(label,data_type,p_data,components,p_min,p_max,format,flags)
    flags = flags or 0
    format = format or nil
    return lib.igSliderScalarN(label,data_type,p_data,components,p_min,p_max,format,flags)
end
M.SmallButton = lib.igSmallButton
M.Spacing = lib.igSpacing
function M.SplitterBehavior(bb,id,axis,size1,size2,min_size1,min_size2,hover_extend,hover_visibility_delay,bg_col)
    bg_col = bg_col or 0
    hover_extend = hover_extend or 0.0
    hover_visibility_delay = hover_visibility_delay or 0.0
    return lib.igSplitterBehavior(bb,id,axis,size1,size2,min_size1,min_size2,hover_extend,hover_visibility_delay,bg_col)
end
M.StartMouseMovingWindow = lib.igStartMouseMovingWindow
M.StartMouseMovingWindowOrNode = lib.igStartMouseMovingWindowOrNode
function M.StyleColorsClassic(dst)
    dst = dst or nil
    return lib.igStyleColorsClassic(dst)
end
function M.StyleColorsDark(dst)
    dst = dst or nil
    return lib.igStyleColorsDark(dst)
end
function M.StyleColorsLight(dst)
    dst = dst or nil
    return lib.igStyleColorsLight(dst)
end
M.TabBarAddTab = lib.igTabBarAddTab
M.TabBarCloseTab = lib.igTabBarCloseTab
M.TabBarFindMostRecentlySelectedTabForActiveWindow = lib.igTabBarFindMostRecentlySelectedTabForActiveWindow
M.TabBarFindTabByID = lib.igTabBarFindTabByID
M.TabBarProcessReorder = lib.igTabBarProcessReorder
M.TabBarQueueReorder = lib.igTabBarQueueReorder
M.TabBarQueueReorderFromMousePos = lib.igTabBarQueueReorderFromMousePos
M.TabBarRemoveTab = lib.igTabBarRemoveTab
M.TabItemBackground = lib.igTabItemBackground
function M.TabItemButton(label,flags)
    flags = flags or 0
    return lib.igTabItemButton(label,flags)
end
function M.TabItemCalcSize(label,has_close_button)
    local nonUDT_out = ffi.new("ImVec2")
    lib.igTabItemCalcSize(nonUDT_out,label,has_close_button)
    return nonUDT_out
end
M.TabItemEx = lib.igTabItemEx
M.TabItemLabelAndCloseButton = lib.igTabItemLabelAndCloseButton
M.TableBeginApplyRequests = lib.igTableBeginApplyRequests
M.TableBeginCell = lib.igTableBeginCell
M.TableBeginInitMemory = lib.igTableBeginInitMemory
M.TableBeginRow = lib.igTableBeginRow
M.TableDrawBorders = lib.igTableDrawBorders
M.TableDrawContextMenu = lib.igTableDrawContextMenu
M.TableEndCell = lib.igTableEndCell
M.TableEndRow = lib.igTableEndRow
M.TableFindByID = lib.igTableFindByID
M.TableFixColumnSortDirection = lib.igTableFixColumnSortDirection
M.TableGcCompactSettings = lib.igTableGcCompactSettings
M.TableGcCompactTransientBuffers_TablePtr = lib.igTableGcCompactTransientBuffers_TablePtr
M.TableGcCompactTransientBuffers_TableTempDataPtr = lib.igTableGcCompactTransientBuffers_TableTempDataPtr
function M.TableGcCompactTransientBuffers(a1) -- generic version
    if (ffi.istype('ImGuiTable*',a1) or ffi.istype('ImGuiTable',a1) or ffi.istype('ImGuiTable[]',a1)) then return M.TableGcCompactTransientBuffers_TablePtr(a1) end
    if (ffi.istype('ImGuiTableTempData*',a1) or ffi.istype('ImGuiTableTempData',a1) or ffi.istype('ImGuiTableTempData[]',a1)) then return M.TableGcCompactTransientBuffers_TableTempDataPtr(a1) end
    print(a1)
    error'M.TableGcCompactTransientBuffers could not find overloaded'
end
M.TableGetBoundSettings = lib.igTableGetBoundSettings
function M.TableGetCellBgRect(table,column_n)
    local nonUDT_out = ffi.new("ImRect")
    lib.igTableGetCellBgRect(nonUDT_out,table,column_n)
    return nonUDT_out
end
M.TableGetColumnCount = lib.igTableGetColumnCount
function M.TableGetColumnFlags(column_n)
    column_n = column_n or -1
    return lib.igTableGetColumnFlags(column_n)
end
M.TableGetColumnIndex = lib.igTableGetColumnIndex
function M.TableGetColumnName_Int(column_n)
    column_n = column_n or -1
    return lib.igTableGetColumnName_Int(column_n)
end
M.TableGetColumnName_TablePtr = lib.igTableGetColumnName_TablePtr
function M.TableGetColumnName(a1,a2) -- generic version
    if ((ffi.istype('int',a1) or type(a1)=='number') or type(a1)=='nil') then return M.TableGetColumnName_Int(a1) end
    if (ffi.istype('const ImGuiTable*',a1) or ffi.istype('const ImGuiTable',a1) or ffi.istype('const ImGuiTable[]',a1)) then return M.TableGetColumnName_TablePtr(a1,a2) end
    print(a1,a2)
    error'M.TableGetColumnName could not find overloaded'
end
M.TableGetColumnNextSortDirection = lib.igTableGetColumnNextSortDirection
function M.TableGetColumnResizeID(table,column_n,instance_no)
    instance_no = instance_no or 0
    return lib.igTableGetColumnResizeID(table,column_n,instance_no)
end
M.TableGetColumnWidthAuto = lib.igTableGetColumnWidthAuto
M.TableGetHeaderRowHeight = lib.igTableGetHeaderRowHeight
M.TableGetHoveredColumn = lib.igTableGetHoveredColumn
M.TableGetInstanceData = lib.igTableGetInstanceData
M.TableGetMaxColumnWidth = lib.igTableGetMaxColumnWidth
M.TableGetRowIndex = lib.igTableGetRowIndex
M.TableGetSortSpecs = lib.igTableGetSortSpecs
M.TableHeader = lib.igTableHeader
M.TableHeadersRow = lib.igTableHeadersRow
M.TableLoadSettings = lib.igTableLoadSettings
M.TableMergeDrawChannels = lib.igTableMergeDrawChannels
M.TableNextColumn = lib.igTableNextColumn
function M.TableNextRow(row_flags,min_row_height)
    min_row_height = min_row_height or 0.0
    row_flags = row_flags or 0
    return lib.igTableNextRow(row_flags,min_row_height)
end
function M.TableOpenContextMenu(column_n)
    column_n = column_n or -1
    return lib.igTableOpenContextMenu(column_n)
end
M.TablePopBackgroundChannel = lib.igTablePopBackgroundChannel
M.TablePushBackgroundChannel = lib.igTablePushBackgroundChannel
M.TableRemove = lib.igTableRemove
M.TableResetSettings = lib.igTableResetSettings
M.TableSaveSettings = lib.igTableSaveSettings
function M.TableSetBgColor(target,color,column_n)
    column_n = column_n or -1
    return lib.igTableSetBgColor(target,color,column_n)
end
M.TableSetColumnEnabled = lib.igTableSetColumnEnabled
M.TableSetColumnIndex = lib.igTableSetColumnIndex
M.TableSetColumnSortDirection = lib.igTableSetColumnSortDirection
M.TableSetColumnWidth = lib.igTableSetColumnWidth
M.TableSetColumnWidthAutoAll = lib.igTableSetColumnWidthAutoAll
M.TableSetColumnWidthAutoSingle = lib.igTableSetColumnWidthAutoSingle
M.TableSettingsAddSettingsHandler = lib.igTableSettingsAddSettingsHandler
M.TableSettingsCreate = lib.igTableSettingsCreate
M.TableSettingsFindByID = lib.igTableSettingsFindByID
function M.TableSetupColumn(label,flags,init_width_or_weight,user_id)
    flags = flags or 0
    init_width_or_weight = init_width_or_weight or 0.0
    user_id = user_id or 0
    return lib.igTableSetupColumn(label,flags,init_width_or_weight,user_id)
end
M.TableSetupDrawChannels = lib.igTableSetupDrawChannels
M.TableSetupScrollFreeze = lib.igTableSetupScrollFreeze
M.TableSortSpecsBuild = lib.igTableSortSpecsBuild
M.TableSortSpecsSanitize = lib.igTableSortSpecsSanitize
M.TableUpdateBorders = lib.igTableUpdateBorders
M.TableUpdateColumnsWeightFromWidth = lib.igTableUpdateColumnsWeightFromWidth
M.TableUpdateLayout = lib.igTableUpdateLayout
M.TempInputIsActive = lib.igTempInputIsActive
function M.TempInputScalar(bb,id,label,data_type,p_data,format,p_clamp_min,p_clamp_max)
    p_clamp_max = p_clamp_max or nil
    p_clamp_min = p_clamp_min or nil
    return lib.igTempInputScalar(bb,id,label,data_type,p_data,format,p_clamp_min,p_clamp_max)
end
M.TempInputText = lib.igTempInputText
M.Text = lib.igText
M.TextColored = lib.igTextColored
M.TextColoredV = lib.igTextColoredV
M.TextDisabled = lib.igTextDisabled
M.TextDisabledV = lib.igTextDisabledV
function M.TextEx(text,text_end,flags)
    flags = flags or 0
    text_end = text_end or nil
    return lib.igTextEx(text,text_end,flags)
end
function M.TextUnformatted(text,text_end)
    text_end = text_end or nil
    return lib.igTextUnformatted(text,text_end)
end
M.TextV = lib.igTextV
M.TextWrapped = lib.igTextWrapped
M.TextWrappedV = lib.igTextWrappedV
M.TranslateWindowsInViewport = lib.igTranslateWindowsInViewport
M.TreeNode_Str = lib.igTreeNode_Str
M.TreeNode_StrStr = lib.igTreeNode_StrStr
M.TreeNode_Ptr = lib.igTreeNode_Ptr
function M.TreeNode(a1,a2,...) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and a2==nil then return M.TreeNode_Str(a1) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and (ffi.istype('const char*',a2) or ffi.istype('char[]',a2) or type(a2)=='string') then return M.TreeNode_StrStr(a1,a2,...) end
    if ffi.istype('const void*',a1) then return M.TreeNode_Ptr(a1,a2,...) end
    print(a1,a2,...)
    error'M.TreeNode could not find overloaded'
end
function M.TreeNodeBehavior(id,flags,label,label_end)
    label_end = label_end or nil
    return lib.igTreeNodeBehavior(id,flags,label,label_end)
end
function M.TreeNodeBehaviorIsOpen(id,flags)
    flags = flags or 0
    return lib.igTreeNodeBehaviorIsOpen(id,flags)
end
function M.TreeNodeEx_Str(label,flags)
    flags = flags or 0
    return lib.igTreeNodeEx_Str(label,flags)
end
M.TreeNodeEx_StrStr = lib.igTreeNodeEx_StrStr
M.TreeNodeEx_Ptr = lib.igTreeNodeEx_Ptr
function M.TreeNodeEx(a1,a2,a3,...) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and a3==nil then return M.TreeNodeEx_Str(a1,a2) end
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') and (ffi.istype('const char*',a3) or ffi.istype('char[]',a3) or type(a3)=='string') then return M.TreeNodeEx_StrStr(a1,a2,a3,...) end
    if ffi.istype('const void*',a1) then return M.TreeNodeEx_Ptr(a1,a2,a3,...) end
    print(a1,a2,a3,...)
    error'M.TreeNodeEx could not find overloaded'
end
M.TreeNodeExV_Str = lib.igTreeNodeExV_Str
M.TreeNodeExV_Ptr = lib.igTreeNodeExV_Ptr
function M.TreeNodeExV(a1,a2,a3,a4) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.TreeNodeExV_Str(a1,a2,a3,a4) end
    if ffi.istype('const void*',a1) then return M.TreeNodeExV_Ptr(a1,a2,a3,a4) end
    print(a1,a2,a3,a4)
    error'M.TreeNodeExV could not find overloaded'
end
M.TreeNodeV_Str = lib.igTreeNodeV_Str
M.TreeNodeV_Ptr = lib.igTreeNodeV_Ptr
function M.TreeNodeV(a1,a2,a3) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.TreeNodeV_Str(a1,a2,a3) end
    if ffi.istype('const void*',a1) then return M.TreeNodeV_Ptr(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.TreeNodeV could not find overloaded'
end
M.TreePop = lib.igTreePop
M.TreePush_Str = lib.igTreePush_Str
function M.TreePush_Ptr(ptr_id)
    ptr_id = ptr_id or nil
    return lib.igTreePush_Ptr(ptr_id)
end
function M.TreePush(a1) -- generic version
    if (ffi.istype('const char*',a1) or ffi.istype('char[]',a1) or type(a1)=='string') then return M.TreePush_Str(a1) end
    if (ffi.istype('const void*',a1) or type(a1)=='nil') then return M.TreePush_Ptr(a1) end
    print(a1)
    error'M.TreePush could not find overloaded'
end
M.TreePushOverrideID = lib.igTreePushOverrideID
function M.Unindent(indent_w)
    indent_w = indent_w or 0.0
    return lib.igUnindent(indent_w)
end
M.UpdateHoveredWindowAndCaptureFlags = lib.igUpdateHoveredWindowAndCaptureFlags
M.UpdateInputEvents = lib.igUpdateInputEvents
M.UpdateMouseMovingWindowEndFrame = lib.igUpdateMouseMovingWindowEndFrame
M.UpdateMouseMovingWindowNewFrame = lib.igUpdateMouseMovingWindowNewFrame
M.UpdatePlatformWindows = lib.igUpdatePlatformWindows
M.UpdateWindowParentAndRootLinks = lib.igUpdateWindowParentAndRootLinks
function M.VSliderFloat(label,size,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%.3f"
    return lib.igVSliderFloat(label,size,v,v_min,v_max,format,flags)
end
function M.VSliderInt(label,size,v,v_min,v_max,format,flags)
    flags = flags or 0
    format = format or "%d"
    return lib.igVSliderInt(label,size,v,v_min,v_max,format,flags)
end
function M.VSliderScalar(label,size,data_type,p_data,p_min,p_max,format,flags)
    flags = flags or 0
    format = format or nil
    return lib.igVSliderScalar(label,size,data_type,p_data,p_min,p_max,format,flags)
end
M.Value_Bool = lib.igValue_Bool
M.Value_Int = lib.igValue_Int
M.Value_Uint = lib.igValue_Uint
function M.Value_Float(prefix,v,float_format)
    float_format = float_format or nil
    return lib.igValue_Float(prefix,v,float_format)
end
function M.Value(a1,a2,a3) -- generic version
    if (ffi.istype('bool',a2) or type(a2)=='boolean') then return M.Value_Bool(a1,a2) end
    if (ffi.istype('int',a2) or type(a2)=='number') then return M.Value_Int(a1,a2) end
    if ffi.istype('unsigned int',a2) then return M.Value_Uint(a1,a2) end
    if (ffi.istype('float',a2) or type(a2)=='number') then return M.Value_Float(a1,a2,a3) end
    print(a1,a2,a3)
    error'M.Value could not find overloaded'
end
function M.WindowRectAbsToRel(window,r)
    local nonUDT_out = ffi.new("ImRect")
    lib.igWindowRectAbsToRel(nonUDT_out,window,r)
    return nonUDT_out
end
function M.WindowRectRelToAbs(window,r)
    local nonUDT_out = ffi.new("ImRect")
    lib.igWindowRectRelToAbs(nonUDT_out,window,r)
    return nonUDT_out
end

return M
----------END_AUTOGENERATED_LUA-----------------------------