import { CreateTransactionPaymentDto } from './dto/create-transaction_payment.dto';
import { UpdateTransactionPaymentDto } from './dto/update-transaction_payment.dto';
import { Sequelize } from 'sequelize-typescript';
export declare class TransactionPaymentService {
    private sequelize;
    constructor(sequelize: Sequelize);
    create(createTransactionPaymentDto: CreateTransactionPaymentDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateTransactionPaymentDto: UpdateTransactionPaymentDto): string;
    remove(id: number): string;
}
