# Cloudwatch Monitoring

Dockerization of AWS Cloudwatch Monitoring Script.

Cf. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html

## Requirement

This container will run on an Amazon EC2 instance with:
* Docker installed
* Instance profile authorizing sending metrics to Cloudwatch:
    * cloudwatch:PutMetricData
    * cloudwatch:GetMetricStatistics
    * cloudwatch:ListMetrics
    * ec2:DescribeTags

## Running

There is two optional environment variables for running this container:
* `OPTIONS`: list of options as described [below](#options) - default: `--mem-util --swap-util --auto-scaling`
* `CRON`: cron expression for launching this script. - default:  `*/5 * * * *`

Example:

```
docker run --rm -d --name cloudwatch \
		-e OPTIONS="--mem-util --swap-util --disk-space-util --disk-path=/data" \
		-e CRON="* * * * *" \
		sparklane/cloudwatch-monitor
```


## Options<a name="options"></a>

From [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html)

| Name | Description | 
| --- | --- | 
|   `--mem-util `   |  Collects and sends the MemoryUtilization metrics in percentages\. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option\.   | 
|   `--mem-used `   |   Collects and sends the MemoryUsed metrics, reported in megabytes\. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option\.  | 
|   `--mem-used-incl-cache-buff `   |  If you include this option, memory currently used for cache and buffers is counted as "used" when the metrics are reported for `--mem-util`, `--mem-used`, and `--mem-avail`\.  | 
|   `--mem-avail `   |   Collects and sends the MemoryAvailable metrics, reported in megabytes\. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option\.   | 
|   `--swap-util `   |   Collects and sends SwapUtilization metrics, reported in percentages\.   | 
|   `--swap-used `   |   Collects and sends SwapUsed metrics, reported in megabytes\.   | 
|   `--disk-path=PATH `   |   Selects the disk on which to report\.  PATH can specify a mount point or any file located on a mount point for the filesystem that needs to be reported\. For selecting multiple disks, specify a `--disk-path=PATH` for each one of them\.   To select a disk for the filesystems mounted on `/` and `/home`, use the following parameters:  `--disk-path=/ --disk-path=/home`  | 
|   `--disk-space-util`   |  Collects and sends the DiskSpaceUtilization metric for the selected disks\. The metric is reported in percentages\. Note that the disk utilization metrics calculated by this script differ from the values calculated by the df \-k \-l command\. If you find the values from df \-k \-l more useful, you can change the calculations in the script\.  | 
|   `--disk-space-used`   |  Collects and sends the DiskSpaceUsed metric for the selected disks\. The metric is reported by default in gigabytes\.   Due to reserved disk space in Linux operating systems, disk space used and disk space available might not accurately add up to the amount of total disk space\.   | 
|   `--disk-space-avail `   |  Collects and sends the DiskSpaceAvailable metric for the selected disks\. The metric is reported in gigabytes\.   Due to reserved disk space in the Linux operating systems, disk space used and disk space available might not accurately add up to the amount of total disk space\.   | 
|   `--memory-units=UNITS `   |  Specifies units in which to report memory usage\. If not specified, memory is reported in megabytes\. UNITS may be one of the following: bytes, kilobytes, megabytes, gigabytes\.   | 
|   `--disk-space-units=UNITS `   |  Specifies units in which to report disk space usage\. If not specified, disk space is reported in gigabytes\. UNITS may be one of the following: bytes, kilobytes, megabytes, gigabytes\.   | 
|   `--aws-credential- file=PATH `   |  Provides the location of the file containing AWS credentials\.  This parameter cannot be used with the `--aws-access-key-id` and \-`-aws-secret-key` parameters\.   | 
|   `--aws-access-key-id=VALUE `   |  Specifies the AWS access key ID to use to identify the caller\. Must be used together with the `--aws-secret-key` option\. Do not use this option with the `--aws-credential-file` parameter\.   | 
|   `--aws-secret-key=VALUE `   |  Specifies the AWS secret access key to use to sign the request to CloudWatch\. Must be used together with the `--aws-access-key-id` option\. Do not use this option with `--aws-credential-file` parameter\.  | 
|   `--aws-iam-role=VALUE`   |  Specifies the IAM role used to provide AWS credentials\. The value `=VALUE` is required\. If no credentials are specified, the default IAM role associated with the EC2 instance is applied\. Only one IAM role can be used\. If no IAM roles are found, or if more than one IAM role is found, the script will return an error\. Do not use this option with the `--aws-credential-file`, `--aws-access-key-id`, or `--aws-secret-key` parameters\.  | 
|   `--aggregated[=only]`   |  Adds aggregated metrics for instance type, AMI ID, and overall for the region\. The value `=only` is optional; if specified, the script reports only aggregated metrics\.  | 
|   `--auto-scaling[=only]`   |  Adds aggregated metrics for the Auto Scaling group\. The value `=only` is optional; if specified, the script reports only Auto Scaling metrics\. The [IAM policy](http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingPolicies.html) associated with the IAM account or role using the scripts need to have permissions to call the EC2 action [DescribeTags](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeTags.html)\.  | 
|   `--verify `   |  Performs a test run of the script that collects the metrics, prepares a complete HTTP request, but does not actually call CloudWatch to report the data\. This option also checks that credentials are provided\. When run in verbose mode, this option outputs the metrics that will be sent to CloudWatch\.   | 
|   `--from-cron `   |  Use this option when calling the script from cron\. When this option is used, all diagnostic output is suppressed, but error messages are sent to the local system log of the user account\.   | 
|   `--verbose `   |  Displays detailed information about what the script is doing\.   | 
|   `--help `   |  Displays usage information\.   | 
|   `--version `   |  Displays the version number of the script\.   | 