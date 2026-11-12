// File: CustomerDAO.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

public class CustomerDAO extends DAO {
    public CustomerDAO() {
        super();
    }

    public List<Customer> findCustomerByName(String customerName) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM tblCustomer c JOIN tblMember m ON c.memberId = m.id WHERE m.name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + customerName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("memberId"));
                c.setName(rs.getString("name"));
                c.setPhone(rs.getString("phone"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addCustomer(String fullName, String dateOfBirth, String phone, String email, String address,
            String note) {
        boolean kq = false;
        String sqlMember = "INSERT INTO tblMember(name, dateOfBirth, phone, email, address, note) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlCustomer = "INSERT INTO tblCustomer(memberId, customerType) VALUES (?, 'Thường')";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps1 = con.prepareStatement(sqlMember, PreparedStatement.RETURN_GENERATED_KEYS);
            ps1.setString(1, fullName);
            ps1.setString(2, dateOfBirth);
            ps1.setString(3, phone);
            ps1.setString(4, email);
            ps1.setString(5, address);
            ps1.setString(6, note);
            ps1.executeUpdate();
            ResultSet rs = ps1.getGeneratedKeys();
            if (rs.next()) {
                PreparedStatement ps2 = con.prepareStatement(sqlCustomer);
                ps2.setInt(1, rs.getInt(1));
                ps2.executeUpdate();
            }
            con.commit();
            kq = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
            }
            e.printStackTrace();
        }
        return kq;
    }
}