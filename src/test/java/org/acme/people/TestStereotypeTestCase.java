package org.acme.people;

import javax.inject.Inject;
import javax.transaction.Status;
import javax.transaction.UserTransaction;

import org.acme.people.annotations.TransactionalQuarkusTest;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

@TransactionalQuarkusTest
public class TestStereotypeTestCase {

    @Inject
    UserTransaction userTransaction;

    @Test
    public void testUserTransaction() throws Exception {
        Assertions.assertEquals(Status.STATUS_ACTIVE, userTransaction.getStatus());
    }
}