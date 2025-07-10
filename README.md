# Post to Fediverse GitHub Action

This GitHub Action allows you to post a message to a Fediverse instance (like Mastodon, Pleroma, etc.) as part of your workflow.

## How It Works

The action uses a Docker container with `curl` to send a POST request to the status API of a specified Fediverse instance.

## Inputs

| Parameter      | Description                                                 | Required | Default              |
|----------------|-------------------------------------------------------------|----------|----------------------|
| `access_token` | The access token for your Fediverse account.                | `true`   |                      |
| `host_name`    | The hostname of your Fediverse instance (e.g., `mastodon.social`). | `true`   |                      |
| `api_path`     | The API path for posting a status.                          | `false`  | `/api/v1/statuses`   |
| `message`      | The content of the message to post.                         | `true`   |                      |

## Example Usage

To use this action, add the following step to your workflow file (e.g., `.github/workflows/main.yml`). You'll need to store your access token as a secret in your repository's settings.

```yaml
name: Post to Fediverse Example
on:
  push:
    branches:
      - main

jobs:
  post-to-fediverse:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Post to Fediverse
        uses: jmuk/fediverse-post@v1
        with:
          access_token: ${{ secrets.FEDIVERSE_ACCESS_TOKEN }}
          host_name: 'your-instance.com'
          message: 'Hello from a GitHub Action! This is a test post.'
```

## How to Get an Access Token

1.  Go to your Fediverse instance's settings page.
2.  Navigate to the "Development" or "API" section.
3.  Create a new application.
4.  Grant it the `write:statuses` scope.
5.  Your access token will be displayed.

## License

This project is licensed under the [MIT License](LICENSE).
