resource "aws_iam_user" "yangro" {
	name = "yangro"

}

resource "aws_iam_user_policy" "art_devops_black" {
  name  = "super-admin"
  user  = aws_iam_user.yangro.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
