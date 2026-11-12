<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Car Reception Info UI</title></head>
<body>
    <h2>Thông tin phiếu tiếp nhận</h2>
    <% String cusIdStr = request.getParameter("customerId"); String cusName = request.getParameter("customerName");
       if (cusIdStr != null) { session.setAttribute("currentCustomerId", cusIdStr); session.setAttribute("currentCustomerName", cusName); } 
       else { cusIdStr = (String) session.getAttribute("currentCustomerId"); cusName = (String) session.getAttribute("currentCustomerName"); }
       
       List<ServiceRequest> outServiceList = (List<ServiceRequest>) session.getAttribute("outServiceList"); if (outServiceList == null) outServiceList = new ArrayList<>();
       List<SparePartRequest> outSparePartList = (List<SparePartRequest>) session.getAttribute("outSparePartList"); if (outSparePartList == null) outSparePartList = new ArrayList<>();

       if (request.getParameter("subConfirm") != null) {
            Customer customer = new Customer(); customer.setId(Integer.parseInt(cusIdStr)); customer.setName(cusName);
            Car car = new Car(); car.setId(1); 
            CarOwner carOwner = new CarOwner(); carOwner.setCustomer(customer); carOwner.setCar(car); carOwner.setResponsibility("Chủ xe");
            Technician tech = new Technician(); tech.setTechnicianId(Integer.parseInt(request.getParameter("outTechnicianList")));
            
            CarReceptionFormDAO dao = new CarReceptionFormDAO();
            if (dao.saveReceptionForm(dao.createReceptionForm(carOwner, outServiceList, outSparePartList, tech))) {
                session.removeAttribute("outServiceList"); session.removeAttribute("outSparePartList");
                out.print("<script>alert('Tiếp nhận thành công!'); window.location.href='SalesMainUI.jsp';</script>");
            }
       } %>
    
    <p>Khách hàng: <b><%= cusName %></b> (Mã: <%= cusIdStr %>)</p>
    <fieldset>
        <legend>Dịch vụ & Phụ tùng</legend>
        <a href="AddServiceUI.jsp">Thêm dịch vụ</a> | <a href="AddSparePartUI.jsp">Thêm phụ tùng</a>
        <ul>
            <% for(ServiceRequest sr : outServiceList) { %><li><%= sr.getService().getServiceName() %> - <%= sr.getService().getPrice() %> VNĐ</li><% } %>
            <% for(SparePartRequest pr : outSparePartList) { %><li><%= pr.getSparePart().getSparePartName() %> (SL: <%= pr.getQuantity() %>) - <%= pr.getSparePart().getPrice() %> VNĐ</li><% } %>
        </ul>
    </fieldset>
    <form action="CarReceptionInfoUI.jsp" method="post">
        <label>Chọn KTV:</label>
        <select name="outTechnicianList">
            <% for (Technician t : new TechnicianDAO().getTechnicianList()) { %>
                <option value="<%= t.getTechnicianId() %>"><%= t.getName() %> - <%= t.getSpecialization() %></option>
            <% } %>
        </select>
        <input type="submit" name="subConfirm" value="Xác nhận tiếp nhận xe" />
    </form>
</body>
</html>