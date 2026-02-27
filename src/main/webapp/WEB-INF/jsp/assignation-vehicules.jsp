<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignation des Véhicules</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        .card-vehicule {
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .card-vehicule .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .badge-carburant {
            font-size: 0.8rem;
            padding: 5px 10px;
        }
        .table-reservations {
            font-size: 0.9rem;
        }
        .sans-vehicule {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
        }
        .info-section {
            margin-bottom: 30px;
        }
        .filter-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <h1 class="mb-4">
                    <i class="bi bi-truck"></i> 
                    Assignation des Véhicules
                </h1>
                
                <!-- Formulaire de filtre -->
                <div class="filter-form">
                    <form method="get" action="/assignation-vehicules" class="row g-3">
                        <div class="col-md-5">
                            <label for="dateDebut" class="form-label">Date Début</label>
                            <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                                   value="${dateDebut}">
                        </div>
                        <div class="col-md-5">
                            <label for="dateFin" class="form-label">Date Fin</label>
                            <input type="date" class="form-control" id="dateFin" name="dateFin" 
                                   value="${dateFin}">
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary me-2">
                                <i class="bi bi-search"></i> Filtrer
                            </button>
                            <a href="/assignation-vehicules" class="btn btn-secondary">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </a>
                        </div>
                    </form>
                </div>
                
                <!-- Message d'erreur -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                
                <!-- Période affichée -->
                <c:if test="${dateDebut != null and dateFin != null}">
                    <div class="alert alert-info">
                        <i class="bi bi-calendar-range"></i> 
                        Affichage des assignations du <strong>${dateDebut}</strong> au <strong>${dateFin}</strong>
                    </div>
                </c:if>
                
                <!-- Liste des véhicules avec leurs réservations -->
                <div class="info-section">
                    <h2 class="h4 mb-3">
                        <i class="bi bi-truck"></i> 
                        Véhicules et leurs réservations assignées
                    </h2>
                    
                    <c:if test="${empty vehicules}">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-circle"></i> Aucun véhicule trouvé pour cette période.
                        </div>
                    </c:if>
                    
                    <c:forEach var="vehicule" items="${vehicules}">
                        <div class="card card-vehicule">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="bi bi-truck-front"></i> 
                                    <strong>${vehicule.reference}</strong>
                                    <span class="badge bg-secondary ms-2">ID: ${vehicule.id}</span>
                                </div>
                                <div>
                                    <span class="badge badge-carburant ${vehicule.typeCarburant == 'El' ? 'bg-success' : 'bg-warning'}">
                                        <i class="bi ${vehicule.typeCarburant == 'El' ? 'bi-lightning' : 'bi-fuel-pump'}"></i>
                                        ${vehicule.typeCarburant == 'El' ? 'Électrique' : 'Diesel'}
                                    </span>
                                    <span class="badge bg-info ms-2">
                                        <i class="bi bi-people"></i> ${vehicule.nbrPlace} places
                                    </span>
                                    <span class="badge ${vehicule.isOccuped ? 'bg-danger' : 'bg-success'} ms-2">
                                        <i class="bi ${vehicule.isOccuped ? 'bi-lock' : 'bi-unlock'}"></i>
                                        ${vehicule.isOccuped ? 'Occupé' : 'Disponible'}
                                    </span>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty vehicule.reservationsAssign}">
                                    <p class="text-muted mb-0">
                                        <i class="bi bi-info-circle"></i> Aucune réservation assignée à ce véhicule.
                                    </p>
                                </c:if>
                                
                                <c:if test="${not empty vehicule.reservationsAssign}">
                                    <table class="table table-sm table-hover table-reservations">
                                        <thead>
                                            <tr>
                                                <th>ID Réservation</th>
                                                <th>Client</th>
                                                <th>Hôtel</th>
                                                <th>Passagers</th>
                                                <th>Date d'arrivée</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="reservation" items="${vehicule.reservationsAssign}">
                                                <tr>
                                                    <td><span class="badge bg-secondary">#${reservation.id}</span></td>
                                                    <td>${reservation.idClient}</td>
                                                    <td>${reservation.nomHotel}</td>
                                                    <td>
                                                        <span class="badge bg-primary">
                                                            <i class="bi bi-people"></i> ${reservation.nbPassager}
                                                        </span>
                                                    </td>
                                                    <td>${reservation.dateArrivee}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Réservations sans véhicule -->
                <div class="info-section">
                    <h2 class="h4 mb-3 text-warning">
                        <i class="bi bi-exclamation-triangle"></i> 
                        Réservations sans véhicule assigné
                    </h2>
                    
                    <c:if test="${empty reservationsSansVehicule}">
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle"></i> Toutes les réservations ont un véhicule assigné.
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty reservationsSansVehicule}">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-warning">
                                    <tr>
                                        <th>ID Réservation</th>
                                        <th>Client</th>
                                        <th>Hôtel</th>
                                        <th>Nombre de passagers</th>
                                        <th>Date d'arrivée</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="reservation" items="${reservationsSansVehicule}">
                                        <tr class="sans-vehicule">
                                            <td><span class="badge bg-warning">#${reservation.id}</span></td>
                                            <td>${reservation.idClient}</td>
                                            <td>${reservation.nomHotel}</td>
                                            <td>
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-people"></i> ${reservation.nbPassager}
                                                </span>
                                            </td>
                                            <td>${reservation.dateArrivee}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Résumé des réservations sans véhicule -->
                        <div class="alert alert-warning mt-3">
                            <i class="bi bi-info-circle"></i> 
                            <strong>${reservationsSansVehicule.size()}</strong> réservation(s) sans véhicule assigné
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS et dépendances -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>