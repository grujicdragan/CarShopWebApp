/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Dragan
 */

public class DB {

    private static SessionFactory factory;
    private static StandardServiceRegistry serviceRegistry;

    public static Session getSession() {
        try {
            if (factory == null) {
                Configuration cfg = new Configuration().configure("hibernate.cfg.xml");
                cfg.setProperty("hibernate.current_session_context_class", "thread");
                cfg.setProperty("hibernate.connection.characterEncoding", "utf8"); //Omogucava dodavanje ĆĐŠČŽ
                cfg.setProperty("hibernate.enable_lazy_load_no_trans","true");
                StandardServiceRegistryBuilder sb = new StandardServiceRegistryBuilder();
                sb.applySettings(cfg.getProperties());
                serviceRegistry = sb.build();
                factory = cfg.buildSessionFactory(serviceRegistry);
            }
            return factory.getCurrentSession();
        } catch (Throwable ex) {
            System.err.println("Failed to create sessionFactory object." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static void close() {
        if (factory != null) {
            StandardServiceRegistryBuilder.destroy(serviceRegistry);
        }

    }

    public static List query(String query, Object ... params) {
        Transaction tx = null;
        try {
            Session session = getSession();
            tx = session.beginTransaction();
            Query q = session.createQuery(query);
            for(int i=0; i<params.length; i++) {
                q.setParameter(i, params[i]);
            }
            List res = q.list();
            tx.commit();
            return res;
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        }

    }

    public static void insert(Object obj) {
        Transaction tx = null;
        try {
            Session session = getSession();
            tx = session.beginTransaction();
            getSession().save(obj);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        }
    }

    public static void update(Object obj) {
        Transaction tx = null;
        try {
            Session session = getSession();
            tx = session.beginTransaction();
            getSession().update(obj);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        }
    }

    public static void delete(Object obj) {
        Transaction tx = null;
        try {
            Session session = getSession();
            tx = session.beginTransaction();
            getSession().delete(obj);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        }
    }

}