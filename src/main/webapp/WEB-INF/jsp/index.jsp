<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <% if (request.getAttribute("p") != null) { %>
        <base href="<%= request.getContextPath() %>/">
    <% } %>
    <meta charset="UTF-8">
    <title>Mon Application JSP Pur</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        /* Variables de couleurs */
        :root {
            --sidebar-bg: #1a2634;
            --sidebar-hover: #2c3e50;
            --primary: #3498db;
            --success: #27ae60;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light-bg: #f0f2f5;
        }

        body {
            margin: 0;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            background: var(--light-bg);
        }

        /* Sidebar moderne */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            height: 100vh;
            background: var(--sidebar-bg);
            color: #fff;
            padding: 25px 20px;
            overflow-y: auto;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar h2 {
            font-size: 22px;
            margin-bottom: 25px;
            font-weight: 600;
            letter-spacing: 1px;
            padding-left: 10px;
            border-left: 4px solid var(--primary);
        }

        .sidebar hr {
            border-color: rgba(255, 255, 255, 0.1);
            margin: 20px 0;
        }

        .sidebar a {
            color: rgba(255, 255, 255, 0.8);
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            margin: 5px 0;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .sidebar a i {
            width: 20px;
            font-size: 18px;
        }

        .sidebar a:hover {
            background: var(--sidebar-hover);
            color: #fff;
            transform: translateX(5px);
        }

        /* Content area */
        .content {
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
            width: calc(100% - 260px);
            background: var(--light-bg);
        }

        /* Barre de filtre améliorée */
        .filter-section {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .filter-section h1 {
            font-size: 24px;
            margin: 0;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-section h1 i {
            color: var(--primary);
        }

        .filter-form {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-form input {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            min-width: 250px;
            transition: all 0.3s ease;
        }

        .filter-form input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .filter-form button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .filter-form button:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .filter-form a {
            text-decoration: none;
            background: #95a5a6;
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .filter-form a:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }

        /* Messages d'information */
        .info-message {
            background: linear-gradient(135deg, #e8f4fd, #d5e9fa);
            border-left: 5px solid var(--primary);
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.1);
        }

        .info-message i {
            color: var(--primary);
            font-size: 20px;
        }

        /* Tableau amélioré */
        .table-wrapper {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
        }

        th {
            padding: 18px 20px;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        td {
            padding: 16px 20px;
            border-bottom: 1px solid #ecf0f1;
            color: #2c3e50;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
        }

        /* Badges modernes */
        .badge {
            padding: 8px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.3px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .badge-info {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .badge-success {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .badge-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        /* No data */
        .no-data {
            padding: 60px 20px;
            text-align: center;
            color: #7f8c8d;
            font-size: 16px;
        }

        .no-data i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #bdc3c7;
        }

        /* Container pour les pages */
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
            }
            
            .content {
                margin-left: 220px;
                width: calc(100% - 220px);
            }
        }

        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }
            
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                padding: 15px;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            .sidebar h2 {
                width: 100%;
                margin-bottom: 10px;
            }
            
            .sidebar a {
                flex: 1 1 auto;
                justify-content: center;
                padding: 10px;
            }
            
            .content {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }
            
            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-form {
                flex-direction: column;
            }
            
            .filter-form input,
            .filter-form button,
            .filter-form a {
                width: 100%;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .content > * {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2><i class="fas fa-compass" style="margin-right: 10px;"></i>Voyage</h2>
    <hr>
    <a href="<%= request.getContextPath() %>?p=accueil">
        <i class="fas fa-home"></i>Accueil
    </a>
    <a href="<%= request.getContextPath() %>?p=Assignation">
        <i class="fas fa-truck"></i>Assignation-véhicules
    </a>
    <a href="<%= request.getContextPath() %>?p=contact">
        <i class="fas fa-envelope"></i>Contact
    </a>
</div>

<div class="content">
<%
    String p = request.getParameter("p");
    if (p == null) p = "accueil"; 
    if (request.getAttribute("p") != null) {
        p = (String) request.getAttribute("p");
    }

    if ("accueil".equalsIgnoreCase(p)) {
%>
        <%@ include file="reservations.jsp" %>
<%
    } else if ("Assignation".equalsIgnoreCase(p)) {
%>
        <%@ include file="assignation-vehicules.jsp" %>
<%
    } else if ("contact".equalsIgnoreCase(p)) {
%>
        <div class="container">
            <div class="filter-section" style="justify-content: center;">
                <h1><i class="fas fa-envelope"></i>Contact</h1>
            </div>
            <div style="background: white; border-radius: 15px; padding: 40px; text-align: center; box-shadow: 0 5px 25px rgba(0,0,0,0.05);">
                <i class="fas fa-map-marker-alt" style="font-size: 48px; color: var(--primary); margin-bottom: 20px;"></i>
                <h3 style="color: #2c3e50; margin-bottom: 15px;">Comment nous contacter ?</h3>
                <p style="color: #7f8c8d; margin-bottom: 10px;"><i class="fas fa-phone-alt" style="margin-right: 10px;"></i>+33 1 23 45 67 89</p>
                <p style="color: #7f8c8d; margin-bottom: 10px;"><i class="fas fa-envelope" style="margin-right: 10px;"></i>contact@voyage.com</p>
                <p style="color: #7f8c8d;"><i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i>123 Avenue du Voyage, 75001 Paris</p>
            </div>
        </div>
<%
    } else {
%>
        <div class="container">
            <div class="no-data">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Erreur 404</h3>
                <p>La page "<%= p %>" n'existe pas.</p>
            </div>
        </div>
<%
    }
%>
</div>

</body>
</html>