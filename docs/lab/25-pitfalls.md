# 📝 MongoDB Major Version Upgrade Pitfalls

Lets explore *real-world issues* teams have hit when upgrading MongoDB across major versions. Use these scenarios to practice **diagnosing** and **resolving** problems.

---

## Case Study 1: The Silent Feature Block

**Scenario:**
You upgrade from MongoDB 5.0 → 6.0, but some new aggregation operators don’t work. The cluster runs fine otherwise.

**Symptoms:**

* Queries using `$setWindowFields` fail with *“unknown operator”*.
* No errors in `mongod` logs during upgrade.

**Root Cause:**

* The **Feature Compatibility Version (FCV)** was not set properly before the upgrade.
* Cluster is still running in **5.0 compatibility mode**, blocking new features.

**Fix:**

1. Check FCV:

   ```javascript
   db.adminCommand({ getParameter: 1, featureCompatibilityVersion: 1 })
   ```
2. Update FCV to new version:

   ```javascript
   db.adminCommand({ setFeatureCompatibilityVersion: "6.0" })
   ```

---

## Case Study 2: The Broken Config File

**Scenario:**
After upgrading binaries from 4.4 → 5.0, `mongod` won’t start.

**Symptoms:**

* Logs show:

  ```
  Unrecognized option: storage.mmapv1.journal
  try 'mongod --help' for more information
  ```

**Root Cause:**

* **Removed parameter** carried over from old configuration.
* `mmapv1` was deprecated and removed; WiredTiger is the only supported engine.

**Fix:**

* Remove the obsolete config block.
* Update the YAML config file to use WiredTiger defaults.

---

## Case Study 3: The Driver Disconnect

**Scenario:**
After upgrading MongoDB 4.2 → 4.4, your Node.js app starts throwing `MongoTopologyClosedError`.

**Symptoms:**

* App logs full of:

  ```
  Error: Topology was destroyed
  ```
* Database itself looks healthy (`rs.status()` shows all nodes up).

**Root Cause:**

* The application is using an **outdated MongoDB driver** that doesn’t understand new election states in 4.4.

**Fix:**

* Upgrade driver to a version that officially supports the target MongoDB release.
* Example for Node.js:

  ```bash
  npm install mongodb@^4.0
  ```

---

## Case Study 4: Index Chaos

**Scenario:**
You upgrade from 4.2 → 4.4. Afterward, inserts into a collection with a wildcard index fail.

**Symptoms:**

* Error:

  ```
  Cannot create field 'metadata' in element { data: "value" }
  ```
* Only collections with `$**` wildcard indexes affected.

**Root Cause:**

* **Stricter validation** rules for wildcard indexes in newer versions.
* Existing documents violate the stricter indexing rules.

**Fix:**

* Review documents and indexes.
* Drop/recreate the wildcard index with correct options.
* Fix offending documents before retrying inserts.

---

## Case Study 5: Replication Lag from Nowhere

**Scenario:**
During a rolling upgrade from 3.6 → 4.0, secondaries fall hours behind.

**Symptoms:**

* `rs.status()` shows huge `optime` differences.
* Secondary logs full of retryable write entries.

**Root Cause:**

* MongoDB 4.0 introduced **retryable writes** in oplog, making replication more verbose.
* Secondaries on older hardware can’t keep up.

**Fix:**

* Ensure hardware/resources are adequate for new oplog size/throughput.
* Temporarily disable retryable writes for low-criticality workloads during upgrade.

---

## Case Study 6: TLS Trouble

**Scenario:**
You upgrade from 5.0 → 6.0, and suddenly older Java applications can’t connect.

**Symptoms:**

* App logs:

  ```
  javax.net.ssl.SSLHandshakeException: no cipher suites in common
  ```
* MongoDB logs show rejected TLS handshakes.

**Root Cause:**

* MongoDB 6.0 enforces **TLS 1.2+ only**.
* Older clients (Java 7, legacy BI tools) don’t support TLS 1.2.

**Fix:**

* Upgrade clients to newer JVMs or drivers with TLS 1.2 support.
* As a last resort in testing (not production!), temporarily allow weaker ciphers via config.

---

# ✅ Key Takeaways

* Always review **release notes** before upgrading.
* Test upgrades in a **staging environment** with your app workload.
* Monitor logs closely — symptoms are often subtle.
* Remember: **replica set rolling upgrades** and proper FCV management are your best safety nets.

⇨ [Let's upgrade your database...](30-seamless-upgrades.md)
