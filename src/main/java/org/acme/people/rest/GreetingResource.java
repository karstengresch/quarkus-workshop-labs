package org.acme.people.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/add-answer")
@Produces(MediaType.TEXT_PLAIN)
@Consumes(MediaType.TEXT_PLAIN)
public class GreetingResource {

    public static final Logger log = LoggerFactory.getLogger(GreetingResource.class);

    @GET
    @Path("/{inputNumber}")
    public String addAnswer(@DefaultValue("-42") @PathParam("inputNumber") String inputNumber) {
        Integer inputNumberConverted = -1;
        String outputNumber = "-1";
        
        if(!inputNumber.isEmpty())
        {
            inputNumberConverted = Integer.parseInt(inputNumber);
            if (inputNumber.isEmpty()) {
                inputNumberConverted = 0;
            }
        }
        outputNumber = String.valueOf(inputNumberConverted + 42);
        return outputNumber;
    }

    @GET
    public String giveAnswer() {
        return "42";
    }

}