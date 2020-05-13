#!/bin/bash

read -p "adding extensions"
mvn quarkus:add-extension -Dextensions="hibernate-orm-panache, jdbc-h2, jdbc-postgresql, resteasy-jsonb"

read -p "datasource settings"
grep datasource src/main/resources/application.properties

#read -p "create enum EyeColor.java"
#cat <<EOF >src/main/java/org/acme/people/model/EyeColor.java
#package org.acme.people.model;
#
#public enum EyeColor {
#    BLUE, GREEN, HAZEL, BROWN
#}
#EOF
#
#read -p "create model Person.java"
#cat <<EOF >src/main/java/org/acme/people/model/Person.java
#package org.acme.people.model;
#
#import java.time.LocalDate;
#import java.util.List;
#import java.util.stream.Collectors;
#import javax.persistence.Column;
#import javax.persistence.Entity;
#import javax.persistence.EnumType;
#import javax.persistence.Enumerated;
#import io.quarkus.hibernate.orm.panache.PanacheEntity;
#import org.acme.people.model.EyeColor;
#
#@Entity
#public class Person extends PanacheEntity {
#    // the person's name
#    public String name;
#
#    // the person's birthdate
#    public LocalDate birth;
#    
#    // the person's eye color
#    @Enumerated(EnumType.STRING)
#    @Column(length = 8)
#    public EyeColor eyes;
#    
#    // TODO: Add more queries
#}
#EOF
#
#
#read -p "create REST endpoint Person.java"
#cat <<EOF >src/main/java/org/acme/people/model/Person.java
#package org.acme.people.rest;
#
#import java.time.LocalDate;
#import java.util.List;
#import java.util.stream.Collectors;
#import javax.enterprise.event.Observes;
#import javax.transaction.Transactional;
#import javax.ws.rs.GET;
#import javax.ws.rs.Path;
#import javax.ws.rs.PathParam;
#import javax.ws.rs.Produces;
#import javax.ws.rs.QueryParam;
#import javax.ws.rs.core.MediaType;
#import javax.enterprise.context.ApplicationScoped;
#import org.acme.people.model.EyeColor;
#import org.acme.people.model.Person;
#import org.acme.people.utils.CuteNameGenerator;
#import org.acme.people.model.DataTable;
#import io.quarkus.panache.common.Parameters;
#import io.quarkus.runtime.StartupEvent;
#import io.quarkus.hibernate.orm.panache.PanacheQuery;
#
#@Path("/person")
#@ApplicationScoped
#public class PersonResource {
#    @GET
#    @Produces(MediaType.APPLICATION_JSON)
#    public List<Person> getAll() {
#        return Person.listAll();
#    }
#    // TODO: add basic queries
#    // TODO: add datatable query
#    // TODO: Add lifecycle hook
#}
#EOF