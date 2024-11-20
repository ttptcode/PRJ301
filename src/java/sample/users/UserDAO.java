package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import sample.shopping.CLothes2;
import sample.shopping.Cart;
import sample.shopping.Clothes;
import sample.shopping.HistoryUser;
import sample.utils.DBUtils;

public class UserDAO {

    private static final String LOGIN = "SELECT fullName, roleID FROM tblUsers WHERE userID=? AND password=?";
    private static final String SEARCH = "SELECT userID, fullName, roleID FROM tblUsers WHERE fullName LIKE ?";
    private static final String DELETE = "DELETE tblUsers WHERE userID= ?";
    private static final String UPDATE = "UPDATE tblUsers SET fullName=?, roleID=? WHERE userID=?";
    private static final String DUPLICATE = "UPDATE userID WHERE userID=?";
    private static final String INSERT = "INSERT INTO tblUsers (fullName, roleID, password, userID) VALUES (?, ?, ?, ?)";
    private static final String SOURCE = "SELECT * from tblProduct";
    private static final String ADD = "SELECT * from tblProduct WHERE productID=?";
    private static final String QUANTITY = " UPDATE tblProduct SET quantity=quantity-? WHERE productID=?";
    private static final String REMOVECART = " UPDATE tblProduct SET quantity=quantity+? WHERE productID=?";
    private static final String ORDER = "INSERT INTO tblOrder(userID, total, date) VALUES (?, ?, ?)";
    private static final String ORDER_DETAIL = "INSERT INTO tblOrderDetail(productID, price, quantity, OrderID) VALUES (?, ?, ?, ?)";
    private static final String ORDER_HIS = "INSERT INTO OrderHistory(Date, UserName, Product, Quantity, Price, Total) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String TOPUSER = "SELECT TOP 1 userID, fullName, roleID FROM tblUsers";

    private static final String SEARCH_HISTORY = "SELECT * FROM OrderHistory WHERE UserName LIKE ? ";

    public UserDTO topuser() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        UserDTO user = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(TOPUSER);

                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String userID = rs.getString("userID");
                    String roleID = rs.getString("roleID");

                    user = new UserDTO(userID, fullName, roleID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public void OrderHIs(Clothes clothes, UserDTO user) throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement ptm = null;

        ResultSet rs = null;
        try {

            conn = DBUtils.getConnection();

            Instant now = Instant.now();
            Timestamp currenttime = Timestamp.from(now);

            ptm = conn.prepareStatement(ORDER_HIS);

            ptm.setTimestamp(1, currenttime);
            ptm.setString(2, user.getFullName());
            ptm.setString(3, clothes.getName());
            ptm.setInt(4, clothes.getQuantity());
            ptm.setDouble(5, clothes.getPrice());
            ptm.setDouble(6, clothes.getQuantity() * clothes.getPrice());
            ptm.executeUpdate();

        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public List<HistoryUser> getlisthis(UserDTO user) throws SQLException {
        List<HistoryUser> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_HISTORY);
                ptm.setString(1, user.getFullName());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    Timestamp date = rs.getTimestamp("Date");
                    String fullName = rs.getString("UserName");
                    String product = rs.getString("Product");
                    int quantity = rs.getInt("Quantity");
                    double price = rs.getDouble("Price");
                    double total = rs.getDouble("Total");
                    list.add(new HistoryUser(date, fullName, product, quantity, price, total));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public void Order(Cart cart, double totalprice, UserDTO user) throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        PreparedStatement ptm2 = null;
        ResultSet rs = null;
        try {
            int orderid = 0;
            conn = DBUtils.getConnection();

            Instant now = Instant.now();
            Timestamp currenttime = Timestamp.from(now);

            ptm = conn.prepareStatement(ORDER, PreparedStatement.RETURN_GENERATED_KEYS);

            ptm.setString(1, user.getUserID());
            ptm.setDouble(2, totalprice);
            ptm.setTimestamp(3, currenttime);
            ptm.executeUpdate();
            if (conn != null) {
                rs = ptm.getGeneratedKeys();

                if (rs.next()) {
                    orderid = rs.getInt(1);
                }
            }
            ptm2 = conn.prepareStatement(ORDER_DETAIL);
            for (Clothes clothes : cart.getCart().values()) {
                ptm2.setString(1, clothes.getId());
                ptm2.setDouble(2, clothes.getPrice());
                ptm2.setInt(3, clothes.getQuantity());
                ptm2.setInt(4, orderid);
                ptm2.addBatch();

            }
            ptm2.executeBatch();

        } catch (SQLException e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean UpdateCart(String id, int quantity) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {

                ptm = conn.prepareStatement(QUANTITY);
                ptm.setInt(1, quantity);
                ptm.setString(2, id);
                ptm.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return true;

    }

    public boolean RemoveCart(String id, int quantity) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {

                ptm = conn.prepareStatement(REMOVECART);
                ptm.setInt(1, quantity);
                ptm.setString(2, id);

                ptm.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return true;

    }

    public Clothes ADDANDUPDATE(String id, int quantity) throws SQLException {

        Connection conn = null;
        PreparedStatement ptm = null;
        PreparedStatement ptm2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        Clothes list = new Clothes();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm2 = conn.prepareStatement(QUANTITY);
                ptm2.setInt(1, quantity);
                ptm2.setString(2, id);

                ptm = conn.prepareStatement(ADD);
                ptm.setString(1, id);

                rs = ptm.executeQuery();
                ptm2.executeUpdate();
                if (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");

                    list.setId(productID);
                    list.setName(name);
                    list.setQuantity(1);
                    list.setPrice(price);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<CLothes2> Checkshopping() throws SQLException {
        List<CLothes2> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SOURCE);

                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    list.add(new CLothes2(productID, name, price, quantity));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public UserDTO checkLogin(String userID, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        UserDTO user = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOGIN);
                ptm.setString(1, userID);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    user = new UserDTO(userID, fullName, roleID, "********");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DUPLICATE);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<UserDTO> getListUser(String search) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String password = "********";
                    list.add(new UserDTO(userID, fullName, roleID, password));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public boolean delete(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        if (ptm != null) {
            ptm.close();
        }
        if (conn != null) {
            conn.close();
        }
        return check;
    }

    public boolean update(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, user.getFullName());
                ptm.setString(2, user.getRoleID());
                ptm.setString(3, user.getUserID());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        if (ptm != null) {
            ptm.close();
        }
        if (conn != null) {
            conn.close();
        }
        return check;
    }

    public void insert(UserDTO user) throws SQLException, Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            ptm.setString(1, user.getFullName());
            ptm.setString(2, user.getRoleID());
            ptm.setString(3, user.getPassword());
            ptm.setString(4, user.getUserID());
            ptm.executeUpdate();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
