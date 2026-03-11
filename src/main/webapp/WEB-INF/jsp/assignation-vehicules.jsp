<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f5f6fa;
        }

        /* Barre de filtre fixe */
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

        /* Contenu sous la barre fixe */
        .content-wrapper {
            margin-left: 0px;      /* aligné avec sidebar */
            margin-top: 90px;        /* hauteur barre fixe */
            margin-right: 0;
            padding: 0px;         /* même padding horizontal que filter-section */
        }

        /* Cards pour header véhicule */
        .card-vehicule {
            margin-bottom: 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .card-vehicule .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        /* Tables full width */
        .full-width-table {
            width: 100%;
            margin-bottom: 30px;
            border-radius: 5px;
            background-color: #fff;
        }

        .table-reservations th,
        .table-reservations td {
            vertical-align: middle;
            text-align: center;
        }

        .sans-vehicule {
            background-color: #fff3cd;
        }

        .badge-carburant {
            font-size: 0.8rem;
            padding: 5px 10px;
        }

        .info-section h2 {
            margin-top: 30px;
            margin-bottom: 15px;
        }

        /* Message d'erreur ou info */
        .alert {
            margin-top: 15px;
        }
        
    </style>
</head>
<body>

    <!-- Barre de filtre fixe -->
    <div class="filter-section">
        <h1 class="h5 m-0">
            <i class="bi bi-truck"></i> Assignation des Véhicules
        </h1>

        <form method="get" action="/assignation-vehicules">
            <div class="d-flex flex-column">
                <label for="dateDebut" class="form-label mb-0">Date Début</label>
                <input type="date" class="form-control form-control-sm" id="dateDebut" name="dateDebut" value="${dateDebut}">
            </div>
            <div class="d-flex flex-column">
                <label for="dateFin" class="form-label mb-0">Date Fin</label>
                <input type="date" class="form-control form-control-sm" id="dateFin" name="dateFin" value="${dateFin}">
            </div>
            
            <button type="submit" class="btn btn-primary btn-sm">
                <i class="bi bi-search"></i> Filtrer
            </button>
            <a href="/assignation-vehicules" class="btn btn-secondary btn-sm">
                <i class="bi bi-arrow-counterclockwise"></i>
            </a>
        </form>
    </div>

    <!-- Contenu principal -->
    <div class="content-wrapper">

        <!-- Message d'erreur -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
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

        <!-- Véhicules -->
        <div class="info-section">
            <h2 class="h5"><i class="bi bi-truck"></i> Véhicules et leurs réservations assignées</h2>

            <c:if test="${empty vehicules}">
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-circle"></i> Aucun véhicule trouvé pour cette période.
                </div>
            </c:if>

            <c:forEach var="vehicule" items="${vehicules}">
                <!-- Card header véhicule -->
                <div class="card card-vehicule">
                    <div class="card-header d-flex justify-content-between">
                        <div>
                            <i class="bi bi-truck-front"></i> <strong>${vehicule.reference}</strong>
                            <span>Date retour: ${fn:replace(vehicule.dateRetour,'T',' ')}</span>
                            <span class="badge bg-secondary ms-2">ID: ${vehicule.id}</span>
                        </div>
                        <div>
                            <span class="badge badge-carburant ${vehicule.typeCarburant == 'El' ? 'bg-success' : 'bg-warning'}">
                                <i class="bi ${
    vehicule.typeCarburant == 'El' ? 'bi-lightning' :
    vehicule.typeCarburant == 'Es' ? 'bi-fuel-pump' :
    vehicule.typeCarburant == 'D' ? 'bi-truck' :
    'bi-question-circle'
}"></i>

${
    vehicule.typeCarburant == 'El' ? 'Électrique' :
    vehicule.typeCarburant == 'Es' ? 'Essence' :
    vehicule.typeCarburant == 'D' ? 'Diesel' :
    'Inconnu'
}
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
                </div>

                <!-- Table réservations full width -->
                <c:if test="${not empty vehicule.reservationsAssign}">
                    <table class="table table-bordered table-hover full-width-table table-reservations">
                        <thead>
                            <tr>
                                <th>ID Réservation</th>
                                <th>Client</th>
                                <th>Hôtel</th>
                                <th>Passagers</th>
                                <th>Date d'arrivée</th>
                                <th>Date de passage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reservation" items="${vehicule.reservationsAssign}" varStatus="status">
                                <tr>
                                    <td>#${reservation.id}</td>
                                    <td>${reservation.idClient}</td>
                                    <td>${reservation.nomHotel}</td>
                                    <td>${reservation.nbPassager}</td>
                                    <td>${fn:replace(reservation.dateArrivee,'T',' ')}</td>
                                    <td>
                                        ${fn:substring(vehicule.retourListDate[status.index],11,19)}
                                    </td>   
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:forEach>
        </div>

        <!-- Réservations sans véhicule -->
        <div class="info-section">
            <h2 class="h5 text-warning"><i class="bi bi-exclamation-triangle"></i> Réservations sans véhicule assigné</h2>

            <c:if test="${empty reservationsSansVehicule}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle"></i> Toutes les réservations ont un véhicule assigné.
                </div>
            </c:if>

            <c:if test="${not empty reservationsSansVehicule}">
                <table class="table table-bordered table-hover full-width-table">
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
                                <td>#${reservation.id}</td>
                                <td>${reservation.idClient}</td>
                                <td>${reservation.nomHotel}</td>
                                <td>${reservation.nbPassager}</td>
                                <td>${reservation.dateArrivee}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="alert alert-warning mt-3">
                    <i class="bi bi-info-circle"></i> 
                    <strong>${reservationsSansVehicule.size()}</strong> réservation(s) sans véhicule assigné
                </div>
            </c:if>
        </div>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>