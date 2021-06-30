resource "aws_iam_user" "yangro_1" {
	name = "yangro_1"

}

resource "aws_iam_user_policy" "art_devops_black_ynagor_1" {
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
