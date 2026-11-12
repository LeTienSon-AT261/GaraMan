// File: ServiceDAO.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Service;

public class ServiceDAO extends DAO {
    public ServiceDAO() {
        super();
    }

    public List<Service> findServiceByName(String name) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM tblService WHERE serviceName LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setServiceName(rs.getString("serviceName"));
                s.setPrice(rs.getFloat("price"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}