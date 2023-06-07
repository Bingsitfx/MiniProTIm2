import { Injectable } from '@nestjs/common';
import { CreateTransactionPaymentDto } from './dto/create-transaction_payment.dto';
import { UpdateTransactionPaymentDto } from './dto/update-transaction_payment.dto';
import { Sequelize } from 'sequelize-typescript';

@Injectable()
export class TransactionPaymentService {
  constructor(private sequelize: Sequelize) {}
  create(createTransactionPaymentDto: CreateTransactionPaymentDto) {
    return 'This action adds a new transactionPayment';
  }

  findAll() {
    return `This action returns all transactionPayment`;
  }

  findOne(id: number) {
    return `This action returns a #${id} transactionPayment`;
  }

  update(id: number, updateTransactionPaymentDto: UpdateTransactionPaymentDto) {
    return `This action updates a #${id} transactionPayment`;
  }

  remove(id: number) {
    return `This action removes a #${id} transactionPayment`;
  }
}
