# Upgrade aproaches
When running PostgreSQL yourself, there are two main upgrade paths:

- In-place upgrade with pg_upgrade

    Fast, minimal downtime.

    Requires careful orchestration.

- Logical migration with pg_dump / pg_restore or replication tools

    More flexible, but downtime can be longer.

👉 You’ll see the challenges of using pg_upgrade manually, and then you'll make the same process a one-click, fully managed operation.


## The Manual Upgrade Journey

When upgrading PostgreSQL on your own, the process typically involves four big phases: preparation, testing, performing the upgrade, and post-upgrade validation. Each step requires careful orchestration to avoid downtime or data corruption. Let’s look at the steps...

🔧 Manual (Self-Managed) Path

1. Preparation

   - Assess your environment: current version, target version, and extension compatibility.

   - Ensure sufficient disk space and backup storage.

   - Take full backups and test recovery.

   - Install the new PostgreSQL binaries alongside the old version.

2. Testing

   - Run pg_upgrade --check to validate compatibility.

   - Rehearse the upgrade in a staging environment.

   - Measure downtime and plan a cutover window.

3. Performing the Upgrade

   - Stop the old cluster, run pg_upgrade, and re-analyze statistics.

   - Start the new cluster and reconfigure extensions.

   - Rebuild replicas if in a high-availability setup.

4. Post-Upgrade Tasks

   - Verify applications and logs.

   - Compare and tune configuration parameters.

   - Rebuild invalid indexes if flagged.

   - Optimize statistics to ensure optimal performance.


## Challenges with Upgrades
One of the toughest challenges with performing a manual PostgreSQL major version upgrade is the time it takes to create a backup before the process can even begin. For very large, business-critical databases, a backup alone can consume hours—sometimes longer—making it nearly impossible to fit the full upgrade into a reasonable maintenance window. Because of this, some teams are tempted to skip the backup step entirely, running the upgrade without a guaranteed way to recover if something goes wrong. 
While that shortcut might be tolerable in a development or test environment, where data loss is inconvenient but not disastrous, it’s completely unacceptable in production. For mission-critical systems, upgrading without a recovery option is a high-risk gamble that can lead to irreversible data loss and prolonged downtime.



Now, let’s shift the perspective to IBM Cloud Databases in place Major version upgrades. Instead of juggling commands and hoping for the best, the upgrade becomes a safe, predictable process designed with recovery in mind. Hans Cloud’s first priority is ensuring your data is never at risk. Before the upgrade even begins, your instance is placed into read-only mode, ensuring no new changes slip through the cracks. Then a recovery point is ensured, guaranteeing that you can always roll back to a known-good state.

Only after these safety measures are in place does Hans Cloud proceed with the upgrade itself. Behind the scenes, it runs all the steps you’d normally have to manage by hand: validating compatibility, switching binaries, analyzing statistics, reconfiguring extensions, and verifying system health. Once complete, the system is brought back online seamlessly.

The difference is profound. In the manual world, you’re balancing a dozen moving pieces with the constant risk of downtime or data loss. With Hans Cloud, the process is automated, reliable, and—most importantly—recoverable at every step. You don’t have to trust your luck; you can trust the platform.


⇨ [Conclusion](90-conclusion.md)
