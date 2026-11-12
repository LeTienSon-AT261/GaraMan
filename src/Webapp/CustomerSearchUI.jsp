<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Customer Search UI</title></head>
<body>
    <h2>Tìm kiếm khách hàng</h2>
    <form action="CustomerSearchUI.jsp" method="post">
        <input type="text" name="inCustomerName" placeholder="Nhập tên khách hàng" required />
        <input type="submit" name="subSearch" value="Tìm kiếm" />
    </form>
    <br>
    <form action="AddCustomerUI.jsp" method="post">
        <input type="submit" name="subAddCustomer" value="Thêm khách hàng mới" />
    </form>
    <hr>
    <% if (request.getParameter("subSearch") != null) {
            String name = request.getParameter("inCustomerName");
            List<Customer> outCustomerList = new CustomerDAO().findCustomerByName(name);
            if (outCustomerList != null && !outCustomerList.isEmpty()) { %>
                <table border="1">
                    <tr><th>Mã</th><th>Tên</th><th>SĐT</th><th>Chọn</th></tr>
                    <% for (Customer c : outCustomerList) { %>
                    <tr>
                        <td><%= c.getId() %></td><td><%= c.getName() %></td><td><%= c.getPhone() %></td>
                        <td>
                            <form action="CarReceptionInfoUI.jsp" method="post">
                                <input type="hidden" name="customerId" value="<%= c.getId() %>" />
                                <input type="hidden" name="customerName" value="<%= c.getName() %>" />
                                <input type="submit" name="subSelectCustomer" value="Chọn" />
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </table>
    <% } else { out.print("<p>Không tìm thấy khách hàng nào.</p>"); } } %>
</body>
</html>