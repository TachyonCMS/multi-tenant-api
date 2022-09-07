import { model, property } from '@loopback/repository';

model()
export class Member {
    @property()
    id?: number;
    @property()
    public_id?: string;
    @property()
    created_at?: string;
    @property()
    updated_at?: string;
    @property({
        required: true,
    })
    status: string;
}