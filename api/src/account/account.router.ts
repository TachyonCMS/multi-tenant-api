/**
 * Required External Modules and Interfaces
 */

import express, { Request, Response } from "express";
import * as AccountService from "./accounts.service";
import { BaseAccount, Account } from "./account.interface";
import { Accounts } from "./accounts.interface";



/**
 * Router Definition
 */

export const accountsRouter = express.Router();

/**
 * Controller Definitions
 */

// GET accounts

accountsRouter.get("/", async (req: Request, res: Response) => {
    try {
      const accounts: Accounts = await AccountService.findAll();
  
      res.status(200).send(accounts);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });
  
  // GET accounts/:id
  
  accountsRouter.get("/:id", async (req: Request, res: Response) => {
    const id: number = parseInt(req.params.id, 10);
  
    try {
      const account: Account = await AccountService.read(id);
  
      if (account) {
        return res.status(200).send(account);
      }
  
      res.status(404).send("account not found");
    } catch (e) {
      res.status(500).send(e.message);
    }
  });
  
  // POST accounts
  
  accountsRouter.post("/", async (req: Request, res: Response) => {
    try {
      const account: BaseAccount = req.body;
  
      const newAccount = await AccountService.create(account);
  
      res.status(201).json(newAccount);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });
  
  // PUT accounts/:id
  
  accountsRouter.put("/:id", async (req: Request, res: Response) => {
    const id: number = parseInt(req.params.id, 10);
  
    try {
      const accountUpdate: Account = req.body;
  
      const existingAccount: Account = await AccountService.find(id);
  
      if (existingAccount) {
        const updatedAccount = await AccountService.update(id, accountUpdate);
        return res.status(200).json(updatedAccount);
      }
  
      const newAccount = await AccountService.create(accountUpdate);
  
      res.status(201).json(newAccount);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });
  
  // DELETE accounts/:id
  
  accountsRouter.delete("/:id", async (req: Request, res: Response) => {
    try {
      const id: number = parseInt(req.params.id, 10);
      await AccountService.remove(id);
  
      res.sendStatus(204);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });