package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.IDaoLocale2;
import entities.Hotel;
import entities.Ville;

@WebServlet("/HotelController")
public class HotelController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDaoLocale2<Ville> ejb1;
    @EJB
    private IDaoLocale2<Hotel> ejb;

    public HotelController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            afficherFormulaireAjout(request, response);
        } else if ("modifier".equals(action)) {
            afficherFormulaireModification(request, response);
        } else if ("supprimer".equals(action)) {
            supprimerHotel(request, response);
        } else {
            afficherListeVilles(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            ajouterHotel(request, response);
        } else if ("modifier".equals(action)) {
            modifierVille(request, response);
        } else {
            // Handle other actions or redirect appropriately
            response.sendRedirect(request.getContextPath() + "/HotelController");
        }
    }

    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
        dispatcher.forward(request, response);
    }

    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
           Hotel hotel = ejb.findById(id);
           														
            if (hotel != null) {
                request.setAttribute("hotel",hotel );

                RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    private void afficherListeVilles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Hotel> hotels = ejb.findAll();
        request.setAttribute("hotels",hotels);

        RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
        dispatcher.forward(request, response);
    }

    private void ajouterHotel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("hotel");
        String ville = request.getParameter("ville");
        ejb.create(new Hotel(nom , ville));

        // Redirect to display the updated list of cities
        response.sendRedirect(request.getContextPath() + "/HotelController");
    }

    private void modifierVille(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nom = request.getParameter("hotel"); // Assurez-vous que le nom correspond au champ dans le formulaire

        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Hotel hotel = ejb.findById(id);

            if (hotel != null) {
                hotel.setNom(nom);
                ejb.update(hotel);
            }
        }

        // Redirect to display the updated list of hotels
        response.sendRedirect(request.getContextPath() + "/HotelController");
    }
      private List<Hotel> hotelparville(HttpServletRequest request, HttpServletResponse response) {
    	  request.setAttribute("villes",ejb1.findAll());
    	  String villeId = request.getParameter("id");
    	  List<Hotel> hotels =(List<Hotel>) ejb.findByVille(Integer.parseInt(villeId));
  		
    	if(villeId != null) {
    		request.setAttribute("Hotels",hotels);
    	}
    	return hotels ;
      }

    private void supprimerHotel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Hotel hotel = ejb.findById(id);

            if (hotel != null) {
                ejb.delete(hotel);
            }
        }

        // Redirect to display the updated list of cities
        response.sendRedirect(request.getContextPath() + "/HotelController");
    }
    
}