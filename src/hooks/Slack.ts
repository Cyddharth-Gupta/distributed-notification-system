import { IncomingWebhook } from '@slack/webhook';
export class Slack {
    private webhook;
    constructor(SLACK_WEBHOOK_URL: string) {
        this.webhook = new IncomingWebhook(SLACK_WEBHOOK_URL);
    }

    async sendHook(message: string) {
        await this.webhook.send({
            text: `Kafka Consumer Subscribe On Message Made By Siddharth Gupta With This Content :: ${message}`,
        });
    }
}