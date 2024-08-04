<html lang="en"><head>
<script src="scripts.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KHIT AIML DEPT</title>
    <link rel="icon" href="images/a1.jpeg" type="image/icon type">
    <link rel="stylesheet" href="khit.css">
    <style>
.announcement {
  border: 1px solid #2f2f2f; /* Dark gray border */
  border-radius: 12px;
  padding: 30px;
  margin-bottom: 20px;
  background-color: #1a1a1a; /* Dark gray background */
  color: #fff; /* Soft blue text */
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
  transition: box-shadow 0.3s ease-in-out;
}
.login-box{
    position: relative;
    color: #ff004f;
    width: 400px;
    height: 450px;
    background:transparent;
    border: 2px solid rgba(255,255,255,.5);
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    backdrop-filter: blur(15px);
}
h2{
    font-size: 2em;
    color: #fff;
    text-align: center;
}
.input-box{
    position: relative;
    width: 310px;
    margin: 30px 0;
    border-bottom: 2px solid #fff;
}
.input-box label{
    position: absolute;
    top: 50%;
    left: 5px;
    transform:translateY(-50%);
    font-size: 1em;
    color: #fff;
    pointer-events: none;
    transition: .5s;
}
.input-box input:focus~label,
.input-box input:valid~label{
    top: -5px;
}

.input-box input{
    width: 100%;
    height: 50px;
    background: transparent;
    border: none;
    outline: none;
    font-size: 1em;
    color: #fff;
    padding: 0 35px 0 5px;
}
.input-box .icon{
    position: absolute;
    right: 8px;
    color: #fff;
    font-size: 1.2em;
    line-height: 57px;
}
.remember-forget{
    margin: -15px 0 15px;
    font-size: .9em;
    color: #fff;
    display: flex;
    justify-content: space-between;
}
.remember-forget label input{
    margin-right: 3px;
}
.remember-forget a{
    color: #fff;
    text-decoration: none;
}
.remember-forget a:hover{
    text-decoration: underline;
}
.input-box input,
.input-box textarea {
    width: 100%;
    padding: 12px;
    border: none; /* Remove the border */
    border-radius: 6px;
    background: transparent; /* Make the background transparent */
    color: #fff; /* Text color */
    font-size: 1em;
    outline: none; /* Remove the default focus outline */
}

.input-box input:focus,
.input-box textarea:focus {
    border-color: transparent; /* Ensure no border on focus */
    background: transparent; /* Ensure background remains transparent */
}

.input-box label {
    position: absolute;
    top: -10px;
    left: 15px;
    font-size: 0.75em;
    color: #ff004f; /* Label color */
    transition: 0.3s;
}

button{
    width: 100%;
    height: 40px;
    background: #fff;
    border: none;
    outline: none;
    border-radius: 40px;
    cursor: pointer;
    font-size: 1em;
    color: #000;
    font-weight: 500;
}
.register-link{
    font-size: .9em;
    color: #fff;
    text-align: center;
    margin: 25px 0 10px;
}
.register-link p a{
    color: #fff;
    text-decoration: none;
    font-weight: 600;
}
.register-link p a:hover{
    text-decoration: underline;
}
.announcement:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.8);
}

.announcement h3 {
  color: #ff004f; /* Soft blue title */
  text-align: center;
  font-weight: bold;
  transition: color 0.3s ease-in-out;
}

.announcement:hover h3 {
  color: #FFCB9A;
}
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
textarea:-webkit-autofill,
textarea:-webkit-autofill:hover,
textarea:-webkit-autofill:focus,
select:-webkit-autofill,
select:-webkit-autofill:hover,
select:-webkit-autofill:focus {
  -webkit-box-shadow: 0 0 0 1000px #fff inset;
  -webkit-text-fill-color: #fff;
}
.announcement p {
  margin: 0;
  text-align: center;
}

.announcement .date-container {
  position: absolute;
  left: 30px;
  transition: left 0.3s ease-in-out;
}
#contact {
    background-color: #1a1a1a;
    color: #fff;
    padding: 40px 0;
}

.contact-col-1,
.contact-col-2 {
    width: 50%;
    padding: 20px;
}

.contact-col-1 {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.contact-col-2 {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.video-container {
    position: relative;
    padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
    height: 0;
    overflow: hidden;
    max-width: 100%;
    background: #000;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
}

.video-container video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: none;
}

.announcement:hover .date-container {
  left: 25px;
}

.date-button {
  background-color: #2f2f2f;
  color: #FFCB9A;
  border: none;
  padding: 10px 36px;
  font-size: 22px;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
  transition: background-color 0.3s ease-in-out;
}

.date-button:hover {
  background-color: #1a1a1a;
}
#contact {
    position: relative;
    width: 100%;
    height: 100vh; /* Full viewport height */
    overflow: hidden;
}

.video-container {
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.video-container video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover; /* Ensures video covers the entire container */
}

.form-overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
    color: #fff;
    width: 80%;
    max-width: 600px;
}

.form-overlay h2 {
    text-align: center;
    margin-bottom: 20px;
}

.input-box {
    position: relative;
    margin-bottom: 20px;
}

.input-box input,
.input-box textarea {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    background: #fff;
    color: #000;
    font-size: 1em;
    outline: none;
}

.input-box textarea {
    height: 100px;
    resize: none;
}

.input-box label {
    position: absolute;
    top: 0;
    left: 10px;
    font-size: 0.8em;
    color: #fff;
    transition: 0.3s;
}

.input-box input:focus ~ label,
.input-box input:valid ~ label,
.input-box textarea:focus ~ label,
.input-box textarea:valid ~ label {
    top: -20px;
    left: 5px;
    font-size: 0.7em;
}

button {
    width: 100%;
    padding: 10px;
    background:#ff004f;;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1em;
    color: #000;
    font-weight: bold;
}

button:hover {
    background: #FFC107;
}

.date-button:active {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
  transform: translateY(2px);
}
.input-box input[type="text"]:autofill,
.input-box input[type="password"]:autofill {
  -webkit-box-shadow: 0 0 0px 1000px transparent inset !important;
  box-shadow: 0 0 0px 1000px transparent inset !important;
  background-color: transparent !important;
  background-image: none !important;
  color: #fff !important;
}
     #contact {
    position: relative;
    width: 100%;
    height: 100vh; /* Full viewport height */
    overflow: hidden;
}

.video-container {
    position: relative;
    width: 100%;
    height: 100%;
}

.video-container video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover; /* Ensures video covers the entire container */
}

/* Ensure the form-container starts off-screen to the right */
.form-container {
    position: absolute;
    top: 50%;
    right: -360px; /* Initially positioned off-screen */
    transform: translateY(-50%);
    width: 360px; /* Set the width of the form container */
    transition: right 1s ease-out;
}

/* When active, the form-container moves to the center of the screen */
.form-container.active {
    right: 50%; /* Moves the form container to the center */
    transform: translate(50%, -50%); /* Adjust for the container width */
}

/* Ensure the form overlay has proper styling */
.form-overlay {
    background: rgba(255, 255, 255, 0.1); /* Glassmorphism effect */
    backdrop-filter: blur(10px); /* Blurs the background behind the form */
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
    color: #fff;
    width: 100%;
    height: auto;
}


.form-overlay h2 {
    text-align: center;
    margin-bottom: 20px;
}

.input-box {
    position: relative;
    margin-bottom: 20px;
}
.input-box {
    position: relative;
    width: 310px;
    margin: 30px 0;
    border: none; /* Remove border */
}

/* Remove border styling from input elements */
.input-box input {
    width: 100%;
    height: 50px;
    background: transparent; /* Ensure background is transparent */
    border: none; /* Remove border */
    outline: none;
    font-size: 1em;
    color: #fff;
    padding: 0 35px 0 5px;
}

/* Adjust label styling */
.input-box label {
    position: absolute;
    top: 50%;
    left: 5px;
    transform: translateY(-50%);
    font-size: 1em;
    color: #fff;
    pointer-events: none;
    transition: .5s;
}
.input-box input,
.input-box textarea {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    background: #fff;
    color: #000;
    font-size: 1em;
    outline: none;
}

.input-box textarea {
    height: 100px;
    resize: none;
}

.input-box label {
    position: absolute;
    top: 0;
    left: 10px;
    font-size: 0.8em;
    color: #fff;
    transition: 0.3s;
}

.input-box input:focus ~ label,
.input-box input:valid ~ label,
.input-box textarea:focus ~ label,
.input-box textarea:valid ~ label {
    top: -20px;
    left: 5px;
    font-size: 0.7em;
}

button {
    width: 100%;
    padding: 10px;
    background:  #ff004f;;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1em;
    color: #000;
    font-weight: bold;
}

button:hover {
    background: #FFC107;
}
       
    </style>
    
</head>
<body>
    <div id="header">
        <div class="container">
            <nav>
                <div class="logo-container">
                    <img src="images/img1.jpg" alt="KHIT Logo" height="80" class="logo">
                    <h1 id="clg">KHIT</h1>
                </div>
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Announcements</a></li>
                    <li><a href="#">Faculty</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </nav>
             <div class="header-text">
                <h1>Welcome to <span>AIML Department</span></h1>
                <p><span>Kallam Haranadha Reddy Institute of Technology</span></p>
            </div>
</div>
    <div id="int">
    <div class="login-box">
        <form method="post" action="validate">
            <h2>Login</h2>
            <div class="input-box">
                <input type="text" name="MYUSER" required="" autocomplete="off">

                <label>REDG.NO</label>
                <span class="icon"></span>
            </div>
            <div class="input-box">
                <input type="password" name="MYPWD" required="" autocomplete="off">
                <label>PASSWORD</label>
                <span class="icon"></span>
            </div>
            <div class="remember-forget">
                <label><input type="checkbox">Remember me</label>
                <a href="forgotpassword.html">Forgot password?</a>
            </div>
            <button type="submit">LOGIN</button>
            <div class="register-link">
                <p>Don't have an account? <a href="registrationform.html">CREATE AN ACCOUNT</a></p>
            </div>
        </form>
    </div>
</div>
    </div>
    
    <div id="announcements">
        <div class="container">
            <h2 class="section-title">Announcements</h2>
            <div id="announcement-list">
                
                            <div class="announcement">
                                <div class="date-container">
                                    <button class="date-button">
                                        <span>21 Jul 2024</span>
                                    </button>
                                </div>
                                <div>
                                    <h3>Holiday</h3>
                                    <p>holiday due to sunday</p>
                                </div>
                            </div>
                
            </div>
        </div>
    </div>
  
<div id="department-hod">
    <div class="container">
        <div class="row">
            <div class="hod-text">
                <h3 class="sub-title">Meet Our Department Head</h3>
                <h2>Dr. G J Sunny Deol</h2>
                <p><strong>Professor and Head of the AIML Department</strong></p>
                <p>With a Ph.D. and 16 years of experience, Dr. Deol is a leading academic figure specializing in Machine Learning, Big Data, and Computer Networks. Known for his innovative teaching and impactful research, he fosters a dynamic learning environment and inspires students and colleagues alike.</p>
                <p>For academic inquiries or collaborations, reach out to Dr. Deol at <a href="mailto:hod-aiml@khitguntur.ac.in">hod-aiml@khitguntur.ac.in</a> or 7799374771.</p>
                <p><strong>Message from the Head:</strong> "At the AIML Department, we are committed to fostering innovation and nurturing talent. Our goal is to empower students with the knowledge and skills needed to excel in the world of AI and ML. Join us in shaping the future of technology."</p>
            </div>
            <div class="hod-image">
                <img src="images/hod.jpg" alt="Department Head">
            </div>
        </div>
    </div>
</div>

<div id="about">
    <div class="container">
        <div class="row">
            <div class="about-col-1">
                <img src="images/a3.jpg" alt="About AIML Image">
            </div>
            <div class="about-col-2">
                <h2 class="sub-title">About AIML</h2>
                <p>At KHIT's AIML Department, we delve into the transformative fields of Artificial 
                    Intelligence (AI) and Machine Learning (ML), shaping the future of technology through 
                    innovation and education. Our commitment to excellence and cutting-edge research equips 
                    students with the skills to tackle complex challenges and lead in a rapidly evolving digital
                    landscape.</p><br>
                    <p><strong>Our Vision:</strong>
                            We envision a world where AI and ML drive significant advancements across various domains,
                            from healthcare and finance to robotics and beyond. Our department strives to be at the forefront 
                            of this technological revolution, preparing our students to be pioneers and thought leaders in these fields.</p>
    <br>
                    <p><strong>Academic Excellence:</strong>

                    Our curriculum is meticulously designed to cover the fundamentals
                    of AI and ML, including deep learning, natural language processing, computer vision, and 
                    reinforcement learning. We emphasize a hands-on approach, allowing students to work on real-world projects
                    and collaborate with industry experts.</p>
            </div>
        </div>
    </div>
</div>
<style>
    /* Overlay styling */
    .form-overlay {
        background: rgba(28, 28, 28, 0.7); /* Dark transparent background */
        backdrop-filter: blur(15px); /* Blurs the background behind the form */
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.8);
        color: #fff;
        width: 80%;
        max-width: 600px;
        margin: auto;
        text-align: center;
    }

    /* Header styling inside the form */
    .form-overlay h2 {
        color: #ff004f; /* Light color for the heading */
        margin-bottom: 20px;
    }

    /* Input and textarea styling */
    .input-box input,
    .input-box textarea {
        width: 100%;
        padding: 12px;
        border: 2px solid #fff; /* Match with theme color */
        border-radius: 6px;
        background: #1a1a1a;
        color: #fff;
        font-size: 1em;
        outline: none;
        margin-bottom: 20px;
    }

    .input-box textarea {
        height: 120px; /* Increase height for better usability */
        resize: vertical; /* Allow vertical resizing */
    }

    /* Label styling */
    .input-box label {
        position: absolute;
        top: -10px;
        left: 15px;
        font-size: 0.75em;
        color: #FFCB9A;
        transition: 0.3s;
    }

    .input-box input:focus ~ label,
    .input-box input:valid ~ label,
    .input-box textarea:focus ~ label,
    .input-box textarea:valid ~ label {
        top: -20px;
        left: 10px;
        font-size: 0.7em;
    }

    /* Button styling */
    button {
        width: 100%;
        padding: 12px;
        background:  #ff004f;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 1em;
        color: #000;
        font-weight: bold;
        transition: background 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    }

    button:hover {
        background: #FFCB9A;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
    }

    /* Focus styling on input and textarea */
    .input-box input:focus,
    .input-box textarea:focus {
        border-color: #ff004f; /* Highlight border color on focus */
    }
    @keyframes slideFromRight {
    0% {
        right: -3600px; /* Start off-screen */
    }
    100% {
        right: 10000px; /* End at 750px from the right edge */
    }
}
 
.form-overlay {
    position: absolute;
    top: 50%;
    right: -3600px; /* Initially positioned off-screen */
    
     transform: translate(-50%, -50%);
    width: 360px; /* Set the width of the form container */
    animation: slideFromRight 3s ease-out 4s forwards; /* Slide animation with delay */
}
    
</style>

 <div id="contact" style="padding-top: 0px;">
        <div class="video-container">
            <video id="background-video" autoplay muted>
                <source src="videos/contact.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            <div class="form-overlay" style="width: 380px;">
                <h2>Contact Us</h2>
                <form method="post" action="submit_contact">
                    <div class="input-box">
                        <input type="text" name="name" required="">
                        <label>Name</label>
                    </div>
                    <div class="input-box">
                        <input type="email" name="email" required="">
                        <label>Email</label>
                    </div>
                    <div class="input-box">
                        <textarea name="message" required=""></textarea>
                        <label>Message</label>
                    </div>
                    <button type="submit">Send Message</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const formContainer = document.querySelector('.form-container');
            formContainer.classList.add('active');

            const video = document.getElementById('background-video');
            const loopDuration = 4; // Duration of the loop in seconds
            let loopStart = 0; // Start of the loop in seconds

            video.addEventListener('loadedmetadata', () => {
                // Calculate the loop start time
                loopStart = Math.max(video.duration - loopDuration, 0);
                video.currentTime = 0; // Ensure video starts from the beginning
            });

            video.addEventListener('timeupdate', () => {
                if (video.currentTime >= video.duration - loopDuration) {
                    video.currentTime = loopStart;
                }
            });
        });
    </script>

<!-- Divider -->



</body></html>