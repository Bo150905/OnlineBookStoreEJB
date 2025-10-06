OnlineBookStore - Source Packaging
===========================
Contents:
- database/: SQL schema + seed data
- src/: Java source for Servlets, EJBs, entities
- WebContent/: JSPs, assets, WEB-INF configurations
- build/: compiled war (optional)
- docs/: onlinebookstore, ERD image
- admin-creds.txt: demo admin accounts (plain text) for grading

How to deploy:
1. Import project into NetBeans (or build with Maven/Ant).
2. Ensure JDBC datasource configured in GlassFish: jdbc/OnlineBookStoreDS -> points to OnlineBookStore DB.
3. Run the SQL script database/OnlineBookStore_schema.sql to create tables and seed data.
4. Deploy OnlineBookStore.war to GlassFish or run from IDE.
5. Login as admin using credentials in admin-creds.txt.

Security notes:
- For production, always hash passwords (BCrypt) and remove admin-creds.txt from server.
- Use HTTPS for sensitive data.
