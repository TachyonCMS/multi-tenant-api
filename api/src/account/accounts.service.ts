/**
 * Data Model Interfaces
 */
import { BaseAccount, Account } from "./account.interface";
import { Accounts } from "./accounts.interface";

import sql from '../db'

/**
 * In-Memory Store
 */

 let accounts: Accounts = [
    {
      id: 1,
      public_id: 'defwefe-erferferfve-weferfwef-wedfwe',
      status: 'pending',
      created_at: '2021-02-13',
      updated_at: ''
    },
    {
      id: 2,
      public_id: 'defwefe-erferferfve-weferfwef-wedfwe',
      status: 'pending',
      created_at: '2021-02-13',
      updated_at: ''
    },
    {
      id: 3,
      public_id: 'defwefe-erferferfve-weferfwef-wedfwe',
      status: 'pending',
      created_at: '2021-02-13',
      updated_at: ''
    }
]
  ;

/**
 * Service Methods
 */

/**
 * CREATE
 * 
 * @param newAccount 
 */
export const create = async (newAccount: BaseAccount): Promise<Account> => {

    return {
        id: 1,
        public_id: 'tenant_1',
        status: 'pending',
        created_at: 'erfwfw',
        updated_at: 'regegfe'
    };

}

/**
 * READ
 * 
 * @param id 
 */
export const read = async (id: number): Promise<Account> => {

    return {
        id: 1,
        public_id: 'tenant_1',
        status: 'pending',
        created_at: 'erfwfw',
        updated_at: 'regegfe'
    };
};

/**
 * UPDATE
 * 
 * @param id 
 * @param accountUpdate 
 * @returns 
 */
export const update = async (
    id: number,
    accountUpdate: BaseAccount
): Promise<Account | null> => {
    const account = await find(id);

    if (!account) {
        return null;
    }

    return {
        id: 1,
        public_id: 'tenant_1',
        status: 'pending',
        created_at: 'erfwfw',
        updated_at: 'regegfe'
    };
};

/**
 * DELETE 
 * 
 * @param id 
 * @returns 
 */
export const remove = async (id: number): Promise<null | void> => {
    const account = await find(id);

    if (!account) {
        return null;
    }

    //delete accounts[id];
};

/**
 * LIST
 * 
 */
 export const findAll = async (): Promise<Accounts> => {

    await sql`set search_path = members, common;`;

    const accounts = await sql`
    select
      *
    from account`;

    return accounts;
};

