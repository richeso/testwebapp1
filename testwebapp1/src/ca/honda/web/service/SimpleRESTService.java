package ca.honda.web.service;

/*
 *  Taken from: 
 *  http://www.mastertheboss.com/web/angularjs/build-a-restful-application-using-jqgrid
 */

import java.io.StringReader;

/*
 *  Taken from: 
 *  http://www.mastertheboss.com/web/angularjs/develop-a-rest-application-using-wildfly-and-angularjs
 */
 
import java.util.List;

import javax.ejb.Stateless;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import ca.honda.model.Person; 

@Stateless
@Path("/service")
public class SimpleRESTService {

    @PersistenceContext
    EntityManager em;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPersonList()

    {

        Query query = em.createQuery("FROM Person");
        List<Person> customerList = query.getResultList();
        return customerList;
    }

    @POST
    @Path("/controller")
    @Consumes(MediaType.APPLICATION_JSON)
    public void controller(String message) {
        JsonReader reader = Json.createReader(new StringReader(message));
        JsonObject obj = reader.readObject();

        String oper = obj.getString("oper");
        switch (oper) {
        case "add":
            addElement(obj);
            break;
        case "del":
            deleteElement(obj);
            break;
        default:
            editElement(obj);
        }
    }

    private void editElement(JsonObject obj) {
        String id = obj.getString("id");
        String name = obj.getString("name");
        String surname = obj.getString("surname");
        String address = obj.getString("address");

        Person person = em.find(Person.class, new Long(id));

        person.setName(name);
        person.setSurname(surname);
        person.setAddress(address);
        em.merge(person);

    }

    private void addElement(JsonObject obj) {

        Person person = new Person();
        person.setName(obj.getString("name"));
        person.setSurname(obj.getString("surname"));
        person.setAddress(obj.getString("address"));

        em.persist(person);
        System.out.println("Saved " + person);

    }

    private void deleteElement(JsonObject obj) {

        String id = obj.getString("id");
        Long personId = new Long(id);
        Query query = em.createQuery("delete FROM Person where id = :id");
        query.setParameter("id", personId);
        query.executeUpdate();
        System.out.println("Deleted " + obj);

    }
}
