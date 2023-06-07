import { TransactionPaymentService } from './transaction_payment.service';
import { CreateTransactionPaymentDto } from './dto/create-transaction_payment.dto';
import { UpdateTransactionPaymentDto } from './dto/update-transaction_payment.dto';
export declare class TransactionPaymentController {
    private readonly transactionPaymentService;
    constructor(transactionPaymentService: TransactionPaymentService);
    create(createTransactionPaymentDto: CreateTransactionPaymentDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateTransactionPaymentDto: UpdateTransactionPaymentDto): string;
    remove(id: string): string;
}
