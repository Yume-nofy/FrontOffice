<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Réservations</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Gestion des Réservations</h1>
        
        <div class="filter-section">
            <h3>Filtre par Date d'Arrivée</h3>
            <form method="get" action="/reservations" class="filter-form">
                <input type="date" name="dateFilter" id="dateFilter" 
                       value="${dateFilter}">
                <button type="submit">Filtrer</button>
                <a href="/reservations">Réinitialiser</a>
            </form>
        </div>
        
        <c:if test="${dateFilter != null}">
            <div class="info-message">
                 Affichage des réservations pour le <strong>${dateFilter}</strong>
            </div>
        </c:if>
        
        <div class="table-wrapper">
            <c:if test="${not empty reservations}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Client ID</th>
                            <th>Hôtel ID</th>
                            <th>Nb. Passagers</th>
                            <th>Date d'Arrivée</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reservation" items="${reservations}">
                            <tr>
                                <td><span class="badge badge-info">#${reservation.id}</span></td>
                                <td>${reservation.idclient}</td>
                                <td>${reservation.idhotel}</td>
                                <td><strong>${reservation.nbPassager}</strong> personne<c:if test="${reservation.nbPassager > 1}">s</c:if></td>
                                <td>
                                    <span class="date-info">
                                        <fmt:formatDate value="${reservation.dateArrivee}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty reservations}">
                <div class="no-data">
                    <p> Aucune réservation trouvée pour cette date.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
