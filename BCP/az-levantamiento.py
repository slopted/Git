import os
import json
from azure.identity import DefaultAzureCredential
from azure.mgmt.managementgroups import ManagementGroupsAPI
from azure.mgmt.resource import SubscriptionClient, ResourceManagementClient
import pandas as pd
import matplotlib.pyplot as plt


def export_azure_hierarchy():
    credential = DefaultAzureCredential()

    # Management Groups
    mgmt_client = ManagementGroupsAPI(credential)
    mgmt_groups = list(mgmt_client.management_groups.list())
    mgmt_groups_data = []
    for mg in mgmt_groups:
        mgmt_groups_data.append({
            "id": mg.id,
            "name": mg.name,
            "display_name": mg.display_name,
            "type": mg.type,
        })

    # Subscriptions
    sub_client = SubscriptionClient(credential)
    subscriptions = list(sub_client.subscriptions.list())
    subscriptions_data = []
    for sub in subscriptions:
        subscriptions_data.append({
            "id": sub.subscription_id,
            "display_name": sub.display_name,
            "state": sub.state,
        })

    # Resource Groups and Resources
    all_resource_groups = []
    all_resources = []
    for sub in subscriptions:
        res_client = ResourceManagementClient(credential, sub.subscription_id)
        rgs = list(res_client.resource_groups.list())
        for rg in rgs:
            rg_data = {
                "subscription_id": sub.subscription_id,
                "resource_group": rg.name,
                "location": rg.location,
            }
            all_resource_groups.append(rg_data)
            # Resources in RG
            resources = list(res_client.resources.list_by_resource_group(rg.name))
            for res in resources:
                res_data = {
                    "subscription_id": sub.subscription_id,
                    "resource_group": rg.name,
                    "id": res.id,
                    "name": res.name,
                    "type": res.type,
                    "location": res.location,
                }
                all_resources.append(res_data)

    summary = {
        "management_groups_count": len(mgmt_groups_data),
        "subscriptions_count": len(subscriptions_data),
        "resource_groups_count": len(all_resource_groups),
        "resources_count": len(all_resources),
    }

    detailed = {
        "management_groups": mgmt_groups_data,
        "subscriptions": subscriptions_data,
        "resource_groups": all_resource_groups,
        "resources": all_resources,
    }


    # Create DataFrames
    mgmt_df = pd.DataFrame(mgmt_groups_data)
    subs_df = pd.DataFrame(subscriptions_data)
    rgs_df = pd.DataFrame(all_resource_groups)
    resources_df = pd.DataFrame(all_resources)

    # Export tables to Excel with multiple sheets
    with pd.ExcelWriter("azure_report.xlsx") as writer:
        mgmt_df.to_excel(writer, sheet_name="ManagementGroups", index=False)
        subs_df.to_excel(writer, sheet_name="Subscriptions", index=False)
        rgs_df.to_excel(writer, sheet_name="ResourceGroups", index=False)
        resources_df.to_excel(writer, sheet_name="Resources", index=False)

    # Generate summary plots
    plt.figure(figsize=(8, 4))
    plt.bar(["Management Groups", "Subscriptions", "Resource Groups", "Resources"],
            [len(mgmt_df), len(subs_df), len(rgs_df), len(resources_df)])
    plt.title("Azure Hierarchy Summary")
    plt.ylabel("Count")
    plt.tight_layout()
    plt.savefig("azure_summary.png")
    plt.close()

    # Optional: Generate a simple HTML report
    html_report = f"""
    <html>
    <head>
        <title>Azure Hierarchy Report</title>
        <style>
            body {{ font-family: Arial, sans-serif; }}
            table {{ border-collapse: collapse; width: 100%; margin-bottom: 20px; }}
            th, td {{ border: 1px solid #ddd; padding: 8px; }}
            th {{ background-color: #f2f2f2; }}
        </style>
    </head>
    <body>
        <h1>Azure Hierarchy Report</h1>
        <h2>Summary</h2>
        <ul>
            <li>Management Groups: {len(mgmt_df)}</li>
            <li>Subscriptions: {len(subs_df)}</li>
            <li>Resource Groups: {len(rgs_df)}</li>
            <li>Resources: {len(resources_df)}</li>
        </ul>
        <img src="azure_summary.png" alt="Azure Summary Chart" style="max-width:600px;">
        <h2>Management Groups</h2>
        {mgmt_df.head(10).to_html(index=False)}
        <h2>Subscriptions</h2>
        {subs_df.head(10).to_html(index=False)}
        <h2>Resource Groups</h2>
        {rgs_df.head(10).to_html(index=False)}
        <h2>Resources</h2>
        {resources_df.head(10).to_html(index=False)}
        <p>Full data available in <code>azure_report.xlsx</code>.</p>
    </body>
    </html>
    """

    with open("azure_report.html", "w", encoding="utf-8") as f:
        f.write(html_report)

    with open("azure_summary.json", "w") as f:
        json.dump(summary, f, indent=2)
    with open("azure_detailed.json", "w") as f:
        json.dump(detailed, f, indent=2)

    print("Export complete. See azure_summary.json and azure_detailed.json.")

if __name__ == "__main__":
    export_azure_hierarchy()