<%--
  Created by IntelliJ IDEA.
  User: phamn
  Date: 11/10/2024
  Time: 7:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"
        import="java.util.*,com.example.btl_pttkhttt.DAO.*,com.example.btl_pttkhttt.Model.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng quần áo ABC</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/styles/gdChinhStyle.css">
</head>
<body>
<div class="page-container">
    <!-- Left Panel -->
    <div class="left-panel">
        <div class="profile-section">
            <div class="profile-card text-center">
                <div class="avatar-container mb-3">
                    <img src="../../assets/images/avt.svg" alt="Avatar" class="avatar">
                </div>
                <%
                    NhanVienKho nvk = (NhanVienKho) session.getAttribute("nhanvien");
                    System.out.println(nvk);
                %>
                <h5 class="mb-2" style="font-size: 1.1rem;"><%= nvk.getName() %></h5>
                <p class="mb-3" style="font-size: 0.9rem;"><%= nvk.getRole() %></p>
                <div class="personal-info">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-phone me-2"></i>Phone
                        </div>
                        <div class="info-value"><%= nvk.getPhone() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-envelope me-2"></i>Email
                        </div>
                        <div class="info-value"><%= nvk.getEmail() %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calendar me-2"></i>Date of Birth
                        </div>
                        <div class="info-value"><%= nvk.getBirth() %></div>
                    </div>
                </div>
            </div>
        </div>

        <button class="logout-btn" onclick="window.location.replace('../../index.jsp?err=logout');">
            <i class="fas fa-sign-out-alt me-2"></i>
            Logout
        </button>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <div class="content-wrapper">
            <!-- Store Header -->
            <div class="store-header">
                <div class="store-name">Cửa hàng quần áo ABC</div>
                <div class="store-info">Số 1, Trần Phú, Hà Đông, Hà Nội</div>
                <div class="store-info">0123 456 789</div>
            </div>

            <%-- Form --%>
            <!-- Import Form -->
            <form action="doConfirm.jsp" method="post">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Nhân Viên Nhập Hàng</label>
                        <input type="text" class="form-control search-input"
                               value="<%= nvk.getName() %>" readonly>
                        <input type="hidden" name="employeeId" value="<%= nvk.getId() %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày Nhập</label>
                        <input type="date" class="form-control search-input"
                               name="importDate" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Nhà Cung Cấp</label>
                        <div class="input-group">
                            <input type="text" class="form-control search-input flex-grow-1"
                                   id="supplierName" name="ncc" readonly value="<%= session.getAttribute("nccName") != null ? session.getAttribute("nccName") : "" %>">
                            <input type="hidden" name="supplierId" id="supplierId">
                            <button type="button" class="btn btn-primary btn-sm search-btn"
                                    data-bs-toggle="modal" data-bs-target="#supplierModal">
                                Chọn
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Trang Phục</label>
                        <button type="button" class="btn btn-success search-btn w-100" onclick="return chonTP(this)">
                            Thêm Trang Phục
                        </button>
                    </div>
                </div>

                <!-- Import Items Table -->
                <div class="table-container">
                    <table class="table table-dark table-striped" id="importTable">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã TP</th>
                            <th>Tên</th>
                            <th>Ảnh</th>
                            <th>Mô Tả</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody id="importTableBody">
                            <%
                                String tps = request.getParameter("listTP");
                                if (tps != null) {
                                    String[] tpId = tps.split(",");
                                    ArrayList<TrangPhuc> tpList = new ArrayList<>();
                                    int cnt = 1;
                                    for (String id : tpId) {
                                        TrangPhucDAO tpDAO = new TrangPhucDAO();
                                        TrangPhuc tp = tpDAO.getTrangPhucById(Integer.parseInt(id.split("-")[1]));
                                        tpList.add(tp);
                            %>
                            <tr>
                                <td><%= cnt++ %></td>
                                <td>TP<%= tp.getId() %></td>
                                <td><%= tp.getName() %></td>
                                <td><img src="../../assets/images/TrangPhuc/<%= tp.getPicture() + ".png" %>" class="order-product-img"></td>
                                <td><%= tp.getDes() %></td>
                                <td>
                                    <input type="number" class="form-control quantity-input"
                                           name="<%=tp.getId()%>-quantity" min="1" value="0">
                                </td>
                                <td >
                                    <input type="text" class="form-control price-input"
                                           name="<%=tp.getId()%>-price">
                                </td>
                                <td class="row-total">0</td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-danger remove-row">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                    session.setAttribute("tpList", tpList);
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- Total Amount -->
                <div class="row mb-2">
                    <div class="col-md-12">
                        <h4>Tổng tiền: <span id="totalAmount">0</span> VND</h4>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="row">
                    <div class="col-md-6">
                        <button class="btn btn-secondary" id="back-button" onclick="window.history.back()">
                            <i class="fas fa-arrow-left me-2"></i>Trở về
                        </button>
                    </div>
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-primary search-btn w-100">
                            <i class="fas fa-save me-2"></i>Lưu
                        </button>
                    </div>
                </div>
            </form>

            <!-- Supplier Modal -->
            <div class="modal fade" id="supplierModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content bg-dark">
                        <div class="modal-header">
                            <h5 class="modal-title">Chọn Nhà Cung Cấp</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-dark table-hover">
                                <thead>
                                <tr>
                                    <th>Mã NCC</th>
                                    <th>Tên Nhà Cung Cấp</th>
                                    <th>Thao Tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    NhaCungCapDAO nccDAO = new NhaCungCapDAO();
                                    List<NhaCungCap> nccList = nccDAO.getAllNCC();
                                    for (NhaCungCap ncc : nccList) {
                                %>
                                    <tr>
                                        <td>NCC<%= ncc.getId() %></td>
                                        <td><%= ncc.getName() %></td>
                                        <td>
                                            <button class="btn btn-sm btn-primary select-supplier"
                                                    data-id="<%= ncc.getId() %>"
                                                    data-name="<%= ncc.getId() + "-" + ncc.getName() %>">
                                                Chọn
                                            </button>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Supplier selection
        const supplierButtons = document.querySelectorAll('.select-supplier');
        supplierButtons.forEach(button => {
            button.addEventListener('click', function() {
                const supplierId = this.getAttribute('data-id');
                const supplierName = this.getAttribute('data-name');

                // Assume these elements exist in the form
                document.getElementById('supplierName').value = supplierName;
                document.getElementById('supplierId').value = supplierId;

                const supplierModal = bootstrap.Modal.getInstance(document.getElementById('supplierModal'));
                supplierModal.hide();
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        // Function to update row total
        function updateRowTotal(input1, input2) {
            const row = input.closest('tr');
            const quantity = parseFloat(input1.value) || 0;
            const price = parseFloat(row.querySelector('.input2').textContent) || 0;
            const rowTotal = row.querySelector('.row-total');

            const total = quantity * price;
            rowTotal.textContent = total.toLocaleString('vi-VN');

            updateTotalAmount();
        }

        // Function to update total amount
        function updateTotalAmount() {
            const rowTotals = document.querySelectorAll('.row-total');
            let totalAmount = 0;

            rowTotals.forEach(rowTotal => {
                console.log(rowTotal.textContent.replace(/,/, ''));
                totalAmount += parseFloat(rowTotal.textContent.replace(/,/, ''));
            });

            totalAmount += "000"
            document.getElementById('totalAmount').textContent = totalAmount.toLocaleString('vi-VN');
        }

        // Add event listener to quantity inputs
        const quantityInputs = document.querySelectorAll('.quantity-input');
        const priceInputs = document.querySelectorAll('.price-input');
        quantityInputs.forEach(input => {
            input.addEventListener('input1', function() {
                updateRowTotal(this);
            });
        });
        priceInputs.forEach(input => {
            input.addEventListener('input2', function() {
                updateRowTotal(this);
            });
        });

        // Initial calculation of total amount
        updateTotalAmount();
    });

    function chonTP(button) {
        var nccName = document.getElementById("supplierName");
        window.location.replace("http://localhost:8080/BTL_PTTKHTTT_war_exploded/nhanvien/NhapHang/gdChonTP.jsp?ncc=" + nccName.value);
        return true;
    }
</script>
</body>
</html>