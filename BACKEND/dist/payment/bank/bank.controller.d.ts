import { BankService } from './bank.service';
import { CreateBankDto } from './dto/create-bank.dto';
import { UpdateBankDto } from './dto/update-bank.dto';
export declare class BankController {
    private readonly bankService;
    constructor(bankService: BankService);
    create(createBankDto: CreateBankDto): Promise<any>;
    findAll(): Promise<{
        message: string;
        data: unknown[];
    } | {
        message: any;
        status: number;
    }>;
    findOne(id: string): Promise<any>;
    update(id: string, updateBankDto: UpdateBankDto): Promise<any>;
    remove(id: string): Promise<any>;
}
