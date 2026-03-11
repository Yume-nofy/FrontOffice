<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .filter-section {
            position: fixed;
            top: 0;
            left: 260px;
            right: 0;
            background: #fff;
            padding: 15px 25px;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            border-radius: 0 0 0 0;
        }
         .filter-section form {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: flex-end;
        }
        .content-wrapper{
            margin-top: 100px;
        }

</style>
<!-- Barre de filtre améliorée -->
<div class="content-wrapper">
    <div class="filter-section">
    <h1>
        <i class="fas fa-calendar-check"></i>
        Gestion des Réservations
    </h1>
    <form method="get" action="/reservations" class="filter-form">
        <input type="hidden" name="p" value="accueil">
        <input type="date" name="dateFilter" id="dateFilter" 
               value="${dateFilter}" placeholder="Sélectionner une date">
        <button type="submit">
            <i class="fas fa-search"></i>
            Filtrer
        </button>
        <a href="?p=accueil">
            <i class="fas fa-undo"></i>
            Réinitialiser
        </a>
    </form>
</div>

<!-- Message d'information si filtre actif -->
<c:if test="${dateFilter != null && not empty dateFilter}">
    <div class="info-message">
        <i class="fas fa-info-circle"></i>
        Affichage des réservations pour le <strong>${dateFilter}</strong>
    </div>
</c:if>

<!-- Tableau des réservations -->
<div class="table-wrapper">
    <c:if test="${not empty reservations}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Client</th>
                    <th>Hôtel</th>
                    <th>Passagers</th>
                    <th>Date d'Arrivée</th>
                    <th>Heure d'Arrivée</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reservation" items="${reservations}">
                    <tr>
                        <td>
                            <span class="badge badge-info">
                                <i class="fas fa-hashtag"></i>
                                ${reservation.id}
                            </span>
                        </td>
                        <td>
                            <i class="fas fa-user" style="color: #3498db; margin-right: 5px;"></i>
                            ${reservation.idclient}
                        </td>
                        <td>
                            <i class="fas fa-hotel" style="color: #e67e22; margin-right: 5px;"></i>
                            ${reservation.nomHotel}
                        </td>
                        <td>
                            <span class="badge ${reservation.nbPassager > 2 ? 'badge-warning' : 'badge-success'}">
                                <i class="fas fa-users"></i>
                                ${reservation.nbPassager} personne<c:if test="${reservation.nbPassager > 1}">s</c:if>
                            </span>
                        </td>
                        <td>
                            <i class="far fa-calendar-alt" style="color: #27ae60; margin-right: 5px;"></i>
                            <!-- Afficher la date directement sans formatage si c'est une String -->
                            ${reservation.dateArrivee}
                        </td>
                        <td>
                            <i class="far fa-clock" style="color: #e74c3c; margin-right: 5px;"></i>
                            <!-- Afficher l'heure directement sans formatage si c'est une String -->
                            ${reservation.heureArrivee}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    
    <!-- Message si aucune réservation -->
    <c:if test="${empty reservations}">
        <div class="no-data">
            <i class="fas fa-calendar-times"></i>
            <p>Aucune réservation trouvée pour cette date.</p>
            <c:if test="${dateFilter != null && not empty dateFilter}">
                <a href="${pageContext.request.contextPath}/?p=accueil" style="display: inline-block; margin-top: 15px; padding: 8px 18px; background: #6c757d; color: white; text-decoration: none; border-radius: 8px;">
                    <i class="fas fa-undo"></i>
                    Voir toutes les réservations
                </a>
            </c:if>
        </div>
    </c:if>
</div>

<!-- Ajout de ce bloc pour gérer l'affichage des dates au format approprié -->
<c:if test="${empty reservations && empty dateFilter}">
    <div class="table-wrapper">
        <div class="no-data">
            <i class="fas fa-info-circle"></i>
            <p>Sélectionnez une date pour voir les réservations.</p>
        </div>
    </div>
</c:if>

</div>