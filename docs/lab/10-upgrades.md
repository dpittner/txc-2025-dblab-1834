# Upgrade aproaches
When running PostgreSQL yourself, there are two main upgrade paths:

In-place upgrade with pg_upgrade

    Fast, minimal downtime.

    Requires careful orchestration.

ogical migration with pg_dump / pg_restore or replication tools

    More flexible, but downtime can be longer.

👉 You’ll see the challenges of using pg_upgrade manually, and then you'll make the same process a one-click, fully managed operation.


## Manual Upgrade Journey

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


## IBM Cloud Database in-place Major version upgrades
Now, let’s shift the perspective to IBM Cloud Databases in place Major version upgrades. Instead of juggling commands and hoping for the best, the upgrade becomes a safe, predictable process designed with recovery in mind. IBM Cloud’s first priority is ensuring your data is never at risk. Before the upgrade even begins, your instance is placed into read-only mode, ensuring no new changes slip through the cracks. Then a recovery point is ensured, guaranteeing that you can always roll back to a known-good state.

Only after these safety measures are in place does IBM Cloud proceed with the upgrade itself. Behind the scenes, it runs all the steps you’d normally have to manage by hand: validating compatibility, switching binaries, reconfiguring extensions, and verifying system health. Once complete, the system is brought back writable seamlessly.

The difference is profound. In the manual world, you’re balancing a dozen moving pieces with the constant risk of downtime or data loss. With IBM Cloud Databases in-place Major version upgrades, the process is automated, reliable, and—most importantly—recoverable at every step. You don’t have to trust your luck; you can trust the platform.

In IBM Cloud Databases for PostgreSQL, performing an in-place major version upgrade is designed to be straightforward and flexible, no matter how you interact with the service. You can trigger the upgrade directly from the IBM Cloud Console with just a few clicks, use the CLI if you prefer command-line workflows, call the API for automation, or manage it declaratively through Terraform. In Terraform, it’s literally as simple as updating the version attribute in your ibm_database resource definition—Terraform will handle the orchestration behind the scenes. This consistency across interfaces means teams can choose the workflow that best fits their operations, whether that’s manual management through the UI or fully automated infrastructure-as-code pipelines.

⇨ [Let's upgrade your database...](20-seamless-upgrades.md)
