// File: TechnicianDAO.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Technician;

public class TechnicianDAO extends DAO {
    public TechnicianDAO() {
        super();
    }

    public List<Technician> getTechnicianList() {
        List<Technician> list = new ArrayList<>();
        String sql = "SELECT * FROM tblTechnician t JOIN tblMember m ON t.staffId = m.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Technician t = new Technician();
                t.setTechnicianId(rs.getInt("technicianId"));
                t.setName(rs.getString("name"));
                t.setSpecialization(rs.getString("specialization"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}