// File: SparePartDAO.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.SparePart;

public class SparePartDAO extends DAO {
    public SparePartDAO() {
        super();
    }

    public List<SparePart> findSparePartByName(String name) {
        List<SparePart> list = new ArrayList<>();
        String sql = "SELECT * FROM tblSparePart WHERE sparePartName LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SparePart sp = new SparePart();
                sp.setId(rs.getInt("id"));
                sp.setSparePartName(rs.getString("sparePartName"));
                sp.setPrice(rs.getFloat("price"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}