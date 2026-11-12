
package dao;

import java.sql.PreparedStatement;
import model.Appointment;
import model.Customer;

public class AppointmentDAO extends DAO {
    public AppointmentDAO() {
        super();
    }

    public Appointment createAppointment(Customer customer, java.util.Date date, String time) {
        Appointment appointment = new Appointment();
        appointment.setCustomer(customer);
        appointment.setDate(date);
        appointment.setTime(time);
        appointment.setStatus("Chờ xác nhận");
        return appointment;
    }

    public boolean saveAppointment(Appointment appointment) {
        boolean kq = false;
        String sql = "INSERT INTO tblAppointment (date, time, status, customerId) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(appointment.getDate().getTime()));
            ps.setString(2, appointment.getTime());
            ps.setString(3, appointment.getStatus());
            ps.setInt(4, appointment.getCustomer().getId());
            if (ps.executeUpdate() > 0)
                kq = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}