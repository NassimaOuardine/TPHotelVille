<%@ page import="entities.Ville" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Villes</title>
    <!-- Updated Bootstrap CSS link -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
        }

        .container {
            background-color: #ffffff; /* White container background */
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            color: #007bff; /* Blue header text */
        }

        th {
            background-color: #007bff; /* Blue header background */
            color: #ffffff; /* White header text */
        }

        .form-group label {
            color: #007bff; /* Blue form label text */
        }

        .btn-primary {
            background-color: transparent; /* Transparent primary button */
            border-color: #007bff;
            color: #007bff; /* Blue text for transparent button */
        }

        .btn-warning {
            background-color: #28a745; /* Green warning button */
            border-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545; /* Red danger button */
            border-color: #dc3545;
        }

        .table {
            background-color: #ffffff; /* White table background */
        }

    </style>
</head>
<body>

<div class="container mt-3">
    <h1>Gestion des Villes</h1>

    <form action="VilleController" method="post" class="mt-3">
        <div class="form-group">
            <label for="ville">Nom :</label>
            <input type="text" name="ville" id="ville" class="form-control" required
                   value="${empty ville ? '' : ville.nom}" />
        </div>

        <c:choose>
            <c:when test="${empty ville}">
                <button type="submit" name="action" value="ajouter" class="btn btn-primary">Enregistrer</button>
            </c:when>
            <c:otherwise>
                <button type="submit" name="action" value="modifier" class="btn btn-warning">Modifier</button>
                <input type="hidden" name="id" value="${ville.id}" />
            </c:otherwise>
        </c:choose>
    </form>

    <h2 class="mt-3">Liste des villes :</h2>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${villes}" var="v">
            <tr>
                <td>${v.id}</td>
                <td>${v.nom}</td>
                <td>
                    <a href="#" onclick="modifierVille(${v.id})" class="btn btn-warning btn-sm">Modifier</a>
                    <a href="#" onclick="confirmDelete(${v.id})" class="btn btn-danger btn-sm">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script>
    function confirmDelete(villeId) {
        Swal.fire({
            title: 'Confirmation de suppression',
            text: 'Êtes-vous sûr de vouloir supprimer ce Ville ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Oui, supprimer',
            cancelButtonText: 'Annuler'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'VilleController?action=supprimer&id=' + villeId;
            }
        });
    }
</script>

<script>
    function modifierVille(villeId) {
        window.location.href = 'VilleController?action=modifier&id=' + villeId;
    }
</script>
</body>
</html>