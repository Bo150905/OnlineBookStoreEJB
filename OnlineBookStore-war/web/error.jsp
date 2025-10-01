<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>⚠️ Error Occurred</title>
        <style>
            body {
                background: #0d0d0d;
                color: #00ffcc;
                font-family: "Courier New", monospace;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                overflow: hidden;
            }

            .glitch {
                font-size: 4em;
                font-weight: bold;
                position: relative;
                animation: glitch 1s infinite;
            }

            @keyframes glitch {
                0% {
                    text-shadow: 2px 2px #ff0055, -2px -2px #00fff9;
                }
                20% {
                    text-shadow: -2px 2px #ff0055, 2px -2px #00fff9;
                }
                40% {
                    text-shadow: 2px -2px #ff0055, -2px 2px #00fff9;
                }
                60% {
                    text-shadow: -2px -2px #ff0055, 2px 2px #00fff9;
                }
                100% {
                    text-shadow: 2px 2px #ff0055, -2px -2px #00fff9;
                }
            }

            .message {
                margin-top: 20px;
                font-size: 1.2em;
                text-align: center;
                max-width: 600px;
            }

            .btn {
                margin-top: 40px;
                padding: 12px 25px;
                border: 2px solid #00ffcc;
                color: #00ffcc;
                background: transparent;
                font-size: 1em;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .btn:hover {
                background: #00ffcc;
                color: #0d0d0d;
                box-shadow: 0 0 15px #00ffcc, 0 0 30px #ff0055;
            }

            .matrix {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                color: rgba(0, 255, 200, 0.15);
                font-size: 18px;
                line-height: 18px;
                white-space: nowrap;
                overflow: hidden;
                z-index: -1;
            }
        </style>
    </head>
    <body>
        <div class="matrix">
            ██████╗ ███████╗██████╗ ██████╗  ██████╗ 
            ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔═══██╗
            ██████╔╝█████╗  ██████╔╝██║  ██║██║   ██║
            ██╔═══╝ ██╔══╝  ██╔═══╝ ██║  ██║██║   ██║
            ██║     ███████╗██║     ██████╔╝╚██████╔╝
            ╚═╝     ╚══════╝╚═╝     ╚═════╝  ╚═════╝ 
        </div>

        <div class="glitch">ERROR 500</div>
        <div class="message">
            Oops! Something went wrong on our server.<br>
            Don’t worry, the system admin has already been notified. <br>
            Meanwhile, you can go back to the homepage.
        </div>
        <a href="${pageContext.request.contextPath}/home" class="btn">🔙 Back to Home</a>
    </body>
</html>
