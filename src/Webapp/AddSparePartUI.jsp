<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Add Spare Part UI</title></head>
<body>
    <h2>Thêm phụ tùng</h2>
    <form action="AddSparePartUI.jsp" method="post">
        <input type="text" name="inSparePartName" placeholder="Nhập tên phụ tùng" required />
        <input type="submit" name="subSearchSparePart" value="Tìm kiếm" />
    </form><hr>
    <% if (request.getParameter("subSearchSparePart") != null) {
            List<SparePart> list = new SparePartDAO().findSparePartByName(request.getParameter("inSparePartName"));
            if (list != null && !list.isEmpty()) { %>
                <table border="1"><tr><th>Mã</th><th>Tên</th><th>Giá</th><th>SL</th><th>Chọn</th></tr>
                <% for (SparePart sp : list) { %>
                    <tr>
                        <form action="AddSparePartUI.jsp" method="post">
                            <td><%= sp.getId() %></td><td><%= sp.getSparePartName() %></td><td><%= sp.getPrice() %></td>
                            <td><input type="number" name="inQuantity" value="1" min="1" required style="width:50px;"/></td>
                            <td>
                                <input type="hidden" name="sparePartId" value="<%= sp.getId() %>" />
                                <input type="hidden" name="sparePartName" value="<%= sp.getSparePartName() %>" />
                                <input type="hidden" name="sparePartPrice" value="<%= sp.getPrice() %>" />
                                <input type="submit" name="subSelectSparePart" value="Chọn" />
                            </td>
                        </form>
                    </tr>
                <% } %></table>
    <% } } 
       if (request.getParameter("subSelectSparePart") != null) {
            List<SparePartRequest> list = (List<SparePartRequest>) session.getAttribute("outSparePartList"); if (list == null) list = new ArrayList<>();
            SparePart sp = new SparePart(); sp.setId(Integer.parseInt(request.getParameter("sparePartId"))); sp.setSparePartName(request.getParameter("sparePartName")); sp.setPrice(Float.parseFloat(request.getParameter("sparePartPrice")));
            SparePartRequest pr = new SparePartRequest(); pr.setSparePart(sp); pr.setQuantity(Integer.parseInt(request.getParameter("inQuantity"))); list.add(pr); session.setAttribute("outSparePartList", list);
            response.sendRedirect("CarReceptionInfoUI.jsp");
       } %>
    <br><a href="CarReceptionInfoUI.jsp">Quay lại</a>
</body>
</html>