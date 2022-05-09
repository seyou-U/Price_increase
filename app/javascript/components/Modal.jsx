import React from "react";
import Modal from 'react-modal';
import PropTypes from 'prop-types';

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    height                : '100vh',
    width                : '80%',
    transform             : 'translate(-50%, -50%)',
    overFlow             : 'scroll'
  }
};

const productListStyles = {
    padding             : '5px'
};

class SelectModal extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  render() {
    return (
      <>
        <button onClick={this.openModal}>商品を選択</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Modal">
          <ProductList
            products={this.props.products} />
          <button onClick={this.closeModal}>閉じる</button>
        </Modal>
      </>
    );
  }
}

function ProductList(props) {
    return (
        <>
            {props.products.map((product) => <ProductItem product={product} key={product.id} />)}
        </>
    );
}

ProductList.propTypes = {
    products: PropTypes.array.isRequired
}


function ProductItem(props) {
    const { id } = props.product;
    const { name } = props.product;
    const idStr = JSON.stringify(id)
    return (
        <>
            <div style={productListStyles}>{id}</div>
            <div style={productListStyles}>{name}</div>
            <a href={"/products/"+idStr+"/product_keisan?id="+idStr}>この商品を選択</a>
        </>
    );
}

  ProductItem.propTypes = {
    product: PropTypes.string
  }

export default SelectModal
