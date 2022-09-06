export interface BaseAccount {
    status: string;
}

export interface Account extends BaseAccount {
    id: number;
    public_id: string;
    created_at: string;
    updated_at: string;
}