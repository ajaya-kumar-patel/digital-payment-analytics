# Digital Payments Transaction Analytics

An end-to-end data analytics project on digital payment transactions using **Python, MySQL, SQL, and Power BI**.

The project analyzes transaction trends, customer and merchant behavior, payment success/failure patterns, and potential transaction anomalies to generate business-oriented insights.

## Project Objective

The objective of this project is to analyze digital payment data and answer questions such as:

* How are transaction volume and GMV changing over time?
* Which payment methods are most frequently used?
* What is the overall payment success and failure rate?
* Which customers and merchants contribute the most transaction value?
* What are the major reasons for payment failures?
* How do retry attempts affect payment resolution?

## Tech Stack

* **Python** — Data cleaning and data quality checks
* **MySQL** — Database and SQL analysis
* **Power BI** — Interactive dashboard and visualization
* **Git/GitHub** — Version control and project documentation

## Dataset

The dataset contains four related tables:

| Table                  | Description                  | Records |
| ---------------------- | ---------------------------- | ------: |
| `customers`            | Customer information         |  20,000 |
| `merchants`            | Merchant information         |   2,000 |
| `transactions`         | Digital payment transactions | 300,000 |
| `transaction_failures` | Failed transaction details   |  13,957 |

### Main Transaction Fields

`transaction_id`, `customer_id`, `merchant_id`, `transaction_datetime`, `amount`, `payment_method`, `transaction_status`, `city`, `state`, `device_type`, `transaction_type`

## Database Schema

The project uses a relational database structure:

```text
customers
   |
   | customer_id
   |
transactions
   |
   | merchant_id
   |
merchants

transactions
   |
   | transaction_id
   |
transaction_failures
```

### Relationships

* `customers.customer_id` → `transactions.customer_id`
* `merchants.merchant_id` → `transactions.merchant_id`
* `transactions.transaction_id` → `transaction_failures.transaction_id`

## Data Quality

Before loading the data into MySQL, Python was used to perform basic data-quality checks:

* Missing values
* Duplicate records
* Invalid transaction amounts
* Invalid date/time values
* Category consistency
* Customer and merchant foreign-key consistency

## SQL Analysis

The project uses SQL to perform analysis at different levels.

### Transaction Analysis

* Total transaction count
* Total GMV
* Average transaction value
* Successful GMV
* Success/failure/pending distribution
* Monthly transaction trends
* Payment-method analysis
* Transaction-type analysis

### Customer Analysis

* Customer transaction count
* Customer spending
* Average transaction value
* Active customers
* Customer segments
* Repeat transaction behavior

### Merchant Analysis

* Merchant transaction volume
* Merchant GMV
* Merchant success rate
* Category-level performance
* State-level merchant performance

### Payment Failure Analysis

* Failure rate by payment method
* Failure reasons
* Failed transaction value
* Retry attempts
* Resolution status
* Failure patterns by time and geography

### Advanced SQL

The project also uses:

* `JOIN`
* `GROUP BY`
* `HAVING`
* `CASE WHEN`
* Subqueries
* CTEs
* Window functions
* `ROW_NUMBER()`
* `RANK()`
* `LAG()` / `LEAD()`
* Running totals
* Conditional aggregation

## Analytical Views

Several SQL views were created to provide clean datasets for analysis and Power BI.

Examples:

* `vw_transaction_summary`
* `vw_transaction_status`
* `vw_monthly_trends`
* `vw_customer_metrics`
* `vw_merchant_metrics`
* `vw_payment_failure`
* `vw_customer_activity`
* `vw_transaction_anomalies`

For example, the transaction-status analysis contains:

| Status    | Transactions |
| --------- | -----------: |
| Success   |      282,566 |
| Failed    |       13,957 |
| Pending   |        3,477 |
| **Total** |  **300,000** |

## Power BI Dashboard

The Power BI dashboard is organized into three pages.

### 1. Digital Payments Transaction Overview
<p align="center">
  <img src="screenshots/Transaction Overview.jpg" alt="Transaction Overview Dashboard" width="900">
</p>


### 2. Customer & Merchant Analysis



### 3. Payment Performance


## Potential Anomaly Analysis


## Key Business Questions

The analysis is designed to help answer questions such as:

1. Which payment methods have the highest transaction volume?
2. Which payment methods experience more payment failures?
3. Which merchants generate the highest transaction value?
4. Which customer segments are most active?
5. What are the most common payment failure reasons?
6. When do payment failures occur most frequently?
7. How do retry attempts relate to payment resolution?



## Key Skills Demonstrated

**SQL:** Joins, CTEs, subqueries, window functions, aggregation, conditional logic, analytical views

**Data Analytics:** KPI analysis, trend analysis, customer analysis, merchant analysis, payment-performance analysis

**Python:** Data cleaning and data-quality validation

**Power BI:** Dashboard design, KPI cards, interactive charts, slicers and business reporting
