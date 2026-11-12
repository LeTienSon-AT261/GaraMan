<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Add Service UI</title></head>
<body>
    <h2>Thêm dịch vụ</h2>
    <form action="AddServiceUI.jsp" method="post">
        <input type="text" name="inServiceName" placeholder="Nhập tên dịch vụ" required />
        <input type="submit" name="subSearchService" value="Tìm kiếm" />
    </form><hr>
    <% if (request.getParameter("subSearchService") != null) {
            List<Service> list = new ServiceDAO().findServiceByName(request.getParameter("inServiceName"));
            if (list != null && !list.isEmpty()) { %>
                <table border="1"><tr><th>Mã</th><th>Tên</th><th>Giá</th><th>Chọn</th></tr>
                <% for (Service s : list) { %>
                    <tr>
                        <td><%= s.getId() %></td><td><%= s.getServiceName() %></td><td><%= s.getPrice() %></td>
                        <td>
                            <form action="AddServiceUI.jsp" method="post">
                                <input type="hidden" name="serviceId" value="<%= s.getId() %>" />
                                <input type="hidden" name="serviceName" value="<%= s.getServiceName() %>" />
                                <input type="hidden" name="servicePrice" value="<%= s.getPrice() %>" />
                                <input type="submit" name="subSelectService" value="Chọn" />
                            </form>
                        </td>
                    </tr>
                <% } %></table>
    <% } } 
       if (request.getParameter("subSelectService") != null) {
            List<ServiceRequest> list = (List<ServiceRequest>) session.getAttribute("outServiceList"); if (list == null) list = new ArrayList<>();
            Service s = new Service(); s.setId(Integer.parseInt(request.getParameter("serviceId"))); s.setServiceName(request.getParameter("serviceName")); s.setPrice(Float.parseFloat(request.getParameter("servicePrice")));
            ServiceRequest sr = new ServiceRequest(); sr.setService(s); list.add(sr); session.setAttribute("outServiceList", list);
            response.sendRedirect("CarReceptionInfoUI.jsp");
       } %>
    <br><a href="CarReceptionInfoUI.jsp">Quay lại</a>
</body>
</html>