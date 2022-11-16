
#######################################################################################
# Create users-groups
# - create group peer region
# - default permissions with managed policies EC2 readonly and Cloud9 member
#######################################################################################

resource "aws_iam_group" "group" {
  count = length(var.regions)
  name  = "${var.prefix}-group-${var.regions[count.index]}"
}

#######################################################################################
# Associate default policies to groups (EC2 ReadOnly and Cloud9 Member)

resource "aws_iam_group_policy_attachment" "group_policy-attach-1" {
  count      = length(var.regions)
  group      = aws_iam_group.group[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "group_policy-attach-2" {
  count      = length(var.regions)
  group      = aws_iam_group.group[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloud9EnvironmentMember"
}

