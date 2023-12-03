package services;
import java.util.List;

import dao.IDaoLocale2;
import dao.IDaoRemote;
import entities.Hotel;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "nassim")
@PermitAll
public class HotelService  implements IDaoRemote<Hotel>, IDaoLocale2<Hotel> {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Hotel o) {
		em.remove(em.contains(o) ? o : em.merge(o));
		return true;
	}

	@Override
	public Hotel  update(Hotel o) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Hotel findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Hotel.class, id);
	}

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select v from Hotel v");
		return query.getResultList();
	}

	public List<Hotel> findByVille(int villeId) {
		Query query = em.createQuery("select o from Hotel o WHERE o.ville.id=:villeId ");
		query.setParameter("villeId", villeId);
		return query.getResultList();
	}

}
