<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>RESULTS</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        body {
            background-color: #000000;
            color: #fff;
            margin: 0;
            background-image: url("images/res.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            animation: fadeIn 1s ease-in; /* Animation for body */
        }

        .container {
            padding: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            backdrop-filter: blur(10px); /* Apply background blur */
            -webkit-backdrop-filter: blur(10px); /* Safari support for background blur */
            border-radius: 12px; /* Rounded corners */
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3); /* Light shadow for depth */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Light border */
            padding: 20px; /* Increased padding */
            margin-bottom: 20px;
            color: #fff;
            animation: fadeInUp 1s ease-out; /* Animation for cards */
        }

        .btn-custom {
            background-color: #ff4500; /* Adjusted color to match your theme */
            color: #fff;
            border-radius: 25px;
            text-transform: uppercase;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            animation: pulse 1s infinite; /* Animation for custom button */
        }

        .btn-custom:hover {
            background-color: #ff004f; /* Slightly different hover color */
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: #007bff;
            color: #fff;
            border-radius: 25px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-secondary:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .list-group-item {
            background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Light border */
            color: #fff; /* White text color */
            transition: transform 0.3s; /* Add transition for transform */
        }

        .list-group-item:hover {
            transform: scale(1.02); /* Slightly enlarge on hover */
        }

        .btn-success, .btn-danger {
            border-radius: 20px; /* Rounded corners for buttons */
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
    </style>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body>
    <div class="container mt-5">
        <div class="card">
            <h2 class="text-center">Upload a File</h2>
            <form action="fileServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="file" name="file" class="form-control-file" />
                </div>
                <button type="submit" name="action" value="Upload" class="btn btn-custom">Upload</button>
            </form>
        </div>

        <div class="card mt-5">
            <h2 class="text-center">Available Downloads</h2>
            <form action="fileServlet" method="get">
                <button type="submit" name="action" value="List" class="btn btn-secondary">Refresh List</button>
            </form>
            <ul class="list-group mt-3">
                <%
                    File[] files = (File[]) request.getAttribute("files");
                    if (files != null) {
                        for (File file : files) {
                            if (file.isFile()) {
                                String fileName = file.getName();
                %>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <%= fileName %>
                        <span>
                            <a href="fileServlet?action=Download&fileName=<%= fileName %>" class="btn btn-success btn-sm">Download</a>
                            <a href="fileServlet?action=Delete&fileName=<%= fileName %>" class="btn btn-danger btn-sm">Delete</a>
                        </span>
                    </li>
                <%
                            }
                        }
                    } else {
                %>
                    <li class="list-group-item">No files available for download.</li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</body>

</html>
