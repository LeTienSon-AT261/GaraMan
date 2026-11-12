// File: CarDAO.java
package dao;

import java.sql.PreparedStatement;
import model.Car;

public class CarDAO extends DAO {
    public CarDAO() {
        super();
    }

    public boolean addCar(String nameCar, String licensePlate, String description) {
        boolean kq = false;
        String sql = "INSERT INTO tblCar(nameCar, licensePlate, description) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nameCar);
            ps.setString(2, licensePlate);
            ps.setString(3, description);
            if (ps.executeUpdate() > 0)
                kq = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}