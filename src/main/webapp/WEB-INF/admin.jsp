<%@ include file="includes/header.jspf" %>
    <%@ include file="includes/navbar.jspf" %>

        <c:if test="${sessionScope.user.role != 'ADMIN'}">
            <script>window.location.href = "${pageContext.request.contextPath}/";</script>
        </c:if>

        <div class="container my-5">
            <h1 class="mb-4">Administration</h1>

            <ul class="nav nav-tabs" id="adminTab" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active" id="users-tab" data-bs-toggle="tab" data-bs-target="#users"
                        type="button">Utilisateurs</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="contents-tab" data-bs-toggle="tab" data-bs-target="#contents"
                        type="button">Contenus</button>
                </li>
            </ul>

            <div class="tab-content py-4" id="adminTabContent">
                <!-- Users Tab -->
                <div class="tab-pane fade show active" id="users">
                    <h3>Gestion des utilisateurs</h3>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="u">
                                <tr>
                                    <td>${u.utilisateurId}</td>
                                    <td>${u.nom} ${u.prenom}</td>
                                    <td>${u.email}</td>
                                    <td>${u.role}</td>
                                    <td>
                                        <form
                                            action="${pageContext.request.contextPath}/admin/users/delete/${u.utilisateurId}"
                                            method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                onclick="return confirm('Supprimer cet utilisateur ?')">X</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Contents Tab -->
                <div class="tab-pane fade" id="contents">
                    <h3>Gestion des contenus</h3>
                    <!-- Add Button -->
                    <button class="btn btn-success mb-3">Ajouter un film</button>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Titre</th>
                                <th>Type</th>
                                <th>Note</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${contents}" var="c">
                                <tr>
                                    <td>${c.titre}</td>
                                    <td>${c.typeContenu}</td>
                                    <td>${c.noteMoyenne}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/contents/delete/${c.id}"
                                            method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                onclick="return confirm('Supprimer ce contenu ?')">X</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%@ include file="includes/footer.jspf" %>