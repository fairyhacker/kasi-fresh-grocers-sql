# Kasi Fresh Grocers Database (T-SQL)

A complete SQL Server database solution built for **Kasi Fresh Grocers**, a fictional South African grocery chain with branches across several townships. The project covers database design, data population, business queries, performance tuning, automation, and security.

## What it does

The database models a full retail operation: suppliers, branches, products, customers, orders, and order line items. On top of the schema, the project implements:

- **Business queries** — e.g. total revenue per branch, customers inactive for 90+ days
- **Indexing** — a non-clustered index on `Orders.CustomerID` to speed up common lookups
- **Triggers** — an `AFTER INSERT` trigger on `OrderItems` that blocks negative quantities and logs every insert to an audit table
- **Views** — `vw_SalesSummary`, a joined view combining orders, customers, order items, and products into a single sales report
- **Stored procedures** — loyalty points calculation with tier-based multipliers (Bronze ×2, Silver ×3, Gold ×5, Platinum ×8), including a version with `TRY...CATCH` error handling and transaction management
- **Security** — login/user creation with scoped permissions (e.g. a read-only `ReportUser`), tested against SELECT, INSERT, and EXECUTE access

## Tech used

- SQL Server (T-SQL)
- Developed and tested in VS Code with the mssql extension, running against a Dockerised SQL Server instance

## Structure

The script runs top to bottom and is organised into clearly commented sections:

1. Database and table creation (6 tables with primary/foreign keys)
2. Data population (realistic sample rows per table)
3. Business queries
4. Indexing
5. Triggers and audit logging
6. Views
7. Stored procedures (with and without error handling)
8. Security setup and permission testing
9. Verification queries for every feature above

## How to run

1. Open the `.sql` file in SQL Server Management Studio, Azure Data Studio, or VS Code with the mssql extension
2. Run the script against a SQL Server instance — it creates its own database (`KasiFreshGrocersDB`), so no existing database is needed
3. Execute top to bottom; each section is demarcated with comments and includes its own verification queries

## Author

Dineo Sefatsa — built as part of a Higher Certificate in Data Analytics.
