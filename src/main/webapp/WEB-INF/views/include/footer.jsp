<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Footer-->
<footer id="footer">	
     <div class="wrap">
       <div class="item footer-about">
         <a href="index.html" class="footer-logo">
           <span class="sitename">EasyTrip</span>
         </a>
         <div class="footer-contact">
           <p>A108 Adam Street</p>
           <p>New York, NY 535022</p>
           <p class="mt-3"><strong>Phone:</strong> <span>+1 5589 55488 55</span></p>
           <p><strong>Email:</strong> <span>info@example.com</span></p>
         </div>
       </div>
       <div class="item footer-links">
         <h4>Useful Links</h4>
         <ul>
           <li><i class="bi bi-chevron-right"></i> <a href="#">Home</a></li>
           <li><i class="bi bi-chevron-right"></i> <a href="#">About us</a></li>
           <li><i class="bi bi-chevron-right"></i> <a href="#">Services</a></li>
           <li><i class="bi bi-chevron-right"></i> <a href="#">Terms of service</a></li>
         </ul>
       </div>
      
			 <p class="text-center"><%=request.getSession().getServletContext().getRealPath("/")%></p>
     </div>
</footer>
</footer>