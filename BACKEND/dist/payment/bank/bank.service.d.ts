import { CreateBankDto } from './dto/create-bank.dto';
import { UpdateBankDto } from './dto/update-bank.dto';
import { Sequelize } from 'sequelize-typescript';
export declare class BankService {
    private sequelize;
    constructor(sequelize: Sequelize);
    createBank(createBankDto: CreateBankDto): Promise<any>;
    findAllBank(): Promise<{
        message: string;
        data: unknown[];
    } | {
        message: any;
        status: number;
    }>;
    findOneBank(id: number): Promise<any>;
    updateBank(id: number, updateBankDto: UpdateBankDto): Promise<any>;
    deleteBank(id: number): Promise<any>;
}
