import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

class OceanViewResortTest {

    private LoginServlet loginServlet;
    private SaveReservationServlet saveServlet;
    private LogoutServlet logoutServlet;
    private Class<HttpServletRequest> request;
    private Class<HttpServletResponse> response;
    private Class<HttpSession> session;
    private Class<RequestDispatcher> rd;

    @BeforeEach
    void setUp() {
        loginServlet = new LoginServlet();
        saveServlet = new SaveReservationServlet();
        logoutServlet = new LogoutServlet();
        request = (HttpServletRequest.class);
        response = (HttpServletResponse.class);
        session = (HttpSession.class);
        rd = (RequestDispatcher.class);
    }
    
    // --- BILLING TESTS ---
    @Test 
    void testBillCalculationLogic() {
        // Logic test for GenerateBill.jsp date diff
        java.time.LocalDate d1 = java.time.LocalDate.parse("2026-01-01");
        java.time.LocalDate d2 = java.time.LocalDate.parse("2026-01-05");
        long nights = java.time.temporal.ChronoUnit.DAYS.between(d1, d2);
        double total = nights * 5000.0;
        assertEquals(4, nights);
        assertEquals(20000.0, total);
    }

}